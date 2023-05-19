#It will use node:19-alpine3.16 as the parent image for building the Docker image
FROM getintodevops/jenkins-withdocker:lts

#It will create a working directory for Docker. The Docker image will be created in this working directory.
WORKDIR /react-app

#Copy the React.js application dependencies from the package.json to the react-app working directory.
COPY package.json .

COPY package-lock.json .

#install all the React.js application dependencies
RUN npm i
RUN sudo apt-get update
RUN sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
RUN sudo docker run hello-world
<!-- Copy the remaining React.js application folders and files from the `jenkins-kubernetes-deployment` local folder to the Docker react-app working directory -->
COPY . .

#Expose the React.js application container on port 3000
EXPOSE 3000

#The command to start the React.js application container
CMD ["npm", "start"]
