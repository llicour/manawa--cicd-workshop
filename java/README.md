# Build a CI/CD pipeline for a Java application using imageStream

* SCM             : github (https://github.com)
* CICD platform   : CircleCI (https://circleci.com)
* Docker registry : Quay (https://quay.io/)
* PAAS            : https://master.manawa.dev.adeo.cloud/console/

## Step 1 : Init your Github repo
1. Create a new `hello-world` repo on your github account
2. Copy our sample `hello-world` application somewhere on your filesystem, then init and push your git repo :

```shell
cp -r java/step1/hello-world <path>
cd <path>/hello-world
git init
git add pom.xml src/
git commit -m "first commit"
git remote add origin https://github.com/<your_username>/hello-world.git
git push origin master
```

## Step 2 : Continuous Integration

In this section we are going to build your application using CircleCI and execute some unit tests.

* Add the sample circleci configuration provided in `step2` directory.
* Push CircleCI configuration to github

```shell
cp -r java/step2/.circleci <path>/hello-world
cd <path>/hello-world
git add .circleci
git commit -m "Add CircleCI configuration"
git push origin master
```

* Create your CircleCI account
* Build your project
* You should see an output similar to this :

![Link to environement variaghbles](./Tutorial/screens/circleci-success.png)


You now have a valid continuous integration pipeline that will build and deploy your code on Manawa each time you push an update to github.


## Step 3 : Continuous deployment

### Docker

* Add `docker/Dockerfile` at the root of your project. Then push it to github.

```
cp java/step3/docker/Dockerfile <path>/hello-world
git add Dockerfile
git commit -m "Add dockerfile"
git push origin master
```

### CircleCI configuration

Now we are going to add a deployment step in your existing pipeline to deploy your application on Manawa each time an update is pushed to Github.
The deployment will execute the following steps :
* Init project in Manawa platform
* Build docker image for your app
* Deploy your application in Manawa based on the previously built docker image

You can find the needed configuration files in `step3` directory

* Copy the directory `.circleci` in your project : `.circleci/config.yml`
* Configure CircleCI and add the environment variables needed by the CircleCI configuration file. 

*From the home page of CircleCI:*

![Settings button](./Tutorial/screens/settings-button.png)

![Link to environement variables](./Tutorial/screens/environment-variables-link.png)

> Set the following variables:
> * APP_NAME --> Name your application `node-openshift-ex`
> * PROJECT_NAME --> Create a name for your project. We will need it later. Prefix it with `devweek-`. Please note that your project name must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character (e.g. 'devweek-my-name',  or 'devweek-123-abc') 
> * CLUSTER_URL
> * CLUSTER_USERNAME
> * CLUSTER_PASSWORD

![Environement variables](./Tutorial/screens/environment-variables.png)


* Push CircleCI configuration to github


```shell
git add .circleci/config.yml
git commit -m "Add deployment step"
git push origin master
```

### Test the Continuous Deployment

* Edit this file to 

```shell
git add circleci/
git commit -m "Update CircleCI configuration to deploy on manawa"
git push origin master
```
* Edit the page : `views/index.html`, l. 219 replace :
```html
<h1>Welcome to your Node.js application on OpenShift</h1>
```

by 
```html
<h1>Welcome to <your_username> Node.js application on OpenShift</h1>
```

```shell
git commit -m "Update view index.html to display my username"
git push origin master
```