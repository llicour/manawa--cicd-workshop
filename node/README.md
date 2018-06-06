# Build and deploy nodejs Application to Manawa platform

* Scm             : github (https://github.com)
* CICD platform   : CircleCI (https://circleci.com)
* Docker registry : Quay (https://quay.io/)
* PAAS            : https://master.manawa.dev.adeo.cloud/console/

## Step 1 : Init your github repo

```shell
git clone https://github.com/sclorg/nodejs-ex
cd nodejs-ex
git remote set-url origin https://github.com/<your_username>/nodejs-openshift-ex.git
git push origin master
```

## Step 2 : Build your application with CircleCI

* Add the file `circleci/config-ci.yml` in your project under the following path :  `.circleci/config.yml`
* Push CircleCI configuration to github

```shell
git add circleci/
git commit -m "Add CircleCI configuration"
git push origin master
```

* Create your CircleCI account
* Build your project
* You should see an output similar to this :


You now have a valid continuous integration platform that will build your code each time you push an update to github.

## Step 3 : Deploy your application to manawa PAAS

In this step we will build your application as a docker image, store this image in a docker registry, then deploy an openshift pod using this image in Manawa.

### Docker

* Add `docker/Dockerfile` at the root of your project. Then push it to github.

```
git add Dockerfile
git commit -m "Add dockerfile"
git push origin master
```

* Create your account on quay registry using your github account : https://quay.io/. The images we build will be pushed on this registry.
* Create a quay project and link it to your github project
* Trigger a new build manually to check everything works fine.

### Create your project in manawa

```shell
# Login to manawa using your credentials
oc login https://master.manawa.dev.adeo.cloud -u <your_username>

# Create an empty project in manawa
oc new-project <your_username>-cicd-workshop

# Create an application in your project using your previously built docker image
oc new-app quay.io/<your_username>/node-openshift-ex
```

* Check that your application has been fully deployed :

Create a route to access your service :
```shell
oc expose service node-openshift-ex
```

* Check route has been created :
https://master.manawa.dev.adeo.cloud/console/project/nodejs-ex/browse/routes

* Access your project

### Continuous deploy

* Copy the file `circleci/config-cd.yml` and replace your existing file : `.circleci/config.yml`
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