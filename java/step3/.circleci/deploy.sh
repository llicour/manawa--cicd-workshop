# Login to manawa
oc login -u ${CLUSTER_USERNAME} -p ${CLUSTER_PASSWORD} ${CLUSTER_URL}

# Create or select project in manawa
{
    echo "Select project ${PROJECT_NAME} or create if not exists."
    oc project ${PROJECT_NAME}
} || {
    oc new-project ${PROJECT_NAME}
}

# Build and push docker image to manawa docker registry
docker login -u ${CLUSTER_USERNAME} -p (oc whoami -t) ${DOCKER_REGISTRY_URL}
docker build -t ${DOCKER_REGISTRY_URL}/${PROJECT_NAME}/hello-world:latest .
docker push ${DOCKER_REGISTRY_URL}/${PROJECT_NAME}/hello-world:latest

# Update project kubernetes objects.
oc apply -f kubernetes/hello-world-deployment.yml
oc apply -f kubernetes/hello-world-service.yml
oc apply -f kubernetes/hello-world-route.yml
