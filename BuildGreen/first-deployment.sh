#!/bin/bash
## Revisar si se cuenta con despliegues previos
checkDeployments=$(kubectl get pods -n $EKS_NAMESPACE | grep -v "^NAME" | wc -l| awk '{print $1}')
if [ $checkDeployments -eq 0 ]
then
    echo "[INFO] No previus deployments found in $EKS_NAMESPACE namespace"
    echo "[INFO] Start with the first Deployment"
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-namespace.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-namespace.yaml
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-serviceaccount.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-serviceaccount.yaml
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-deployment-green.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-deployment-green.yaml
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-deployment-blue.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-deployment-blue.yaml
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-service-green.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-service-green.yaml
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-service-blue.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-service-blue.yaml
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-ingress-blue.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-ingress-blue.yaml
    cat              $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-ingress-green.yaml
    kubectl apply -f $CODEBUILD_SRC_DIR_K8sSourceOutput/${RepoK8sDirName}/app-ingress-green.yaml
fi
