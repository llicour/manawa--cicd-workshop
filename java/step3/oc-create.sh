# Login to manawa
oc login -u ${CLUSTER_USERNAME} -p ${CLUSTER_PASSWORD} ${CLUSTER_URL}

# Create or select project in manawa
{
    echo "Select project ${PROJECT_NAME} or create if not exists."
    oc project ${PROJECT_NAME}
} || {
    oc new-project ${PROJECT_NAME}
}