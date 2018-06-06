FROM node
 
# In Openshift containers cannot start using root user. 
# So you have a create a new one.
# Here we create a new group called app and a user also called app
RUN addgroup --system app
RUN adduser --uid 1001 --system --ingroup app app
 
# Set the home directory to our app user's home.
ENV HOME=/home/app
ENV APP_HOME=/home/app/my-project
 
# SETTING UP THE APP
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
 
# ***
# Do any custom logic needed prior to adding your code here
# ***
 
# Copy in the application code.
ADD . $APP_HOME
 
# Chown all the files to the app user.
RUN chown -R app:app $APP_HOME
 
# Change to the app user.
USER 1001
 
COPY package.json .
 
# Install all NodeJS dependences
RUN npm install
COPY . .
 
# Expose the port used by NodeJS server (see server.js)
EXPOSE 8080
CMD ["npm", "start"]