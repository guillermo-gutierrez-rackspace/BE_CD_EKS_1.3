#!/bin/sh

TARGET_FILENAME=AMX-RXS-BE-CD-EKS-CF-1

cat AMX-RXS-BE-CD-EKS-CF.yaml | awk '
$1 == "BuildSpec:" {
  gsub("\047","",$2)
  printf "        BuildSpec: |\n"
  system("cat "$2" | sed -e \"s/^/          /\"")
  next
}
{print}
' > ${TARGET_FILENAME}.yaml

# ENCODE
cat ${TARGET_FILENAME}.yaml | awk '
$2 == "ENCODE" {
  FILE=$3
  "base64 -i "FILE | getline
  close("base64 -i "FILE)
  printf "                - echo \""$0"\" | base64 -d > "FILE"\n"
  next
}
{print}
' > ${TARGET_FILENAME}.tmp

# EMBED
cat ${TARGET_FILENAME}.tmp | awk '
$2 == "EMBED" {
  gsub("\047","",$3)
  FILE=$3
  printf "                - |\n"
  printf "                  cat << \"EOF\" > "FILE"\n"
  system("cat "FILE" | sed -e \"s/^/                  /\"")
  printf "                  EOF\n"
  next
}
{print}
' > ${TARGET_FILENAME}.yaml

rm ${TARGET_FILENAME}.tmp
