pipeline {

  environment {
    dockerimagename = "gabryv/react-app"
    dockerImage = ""
  }

  agent {
  dockerfile true
  }

  stages {

    stage('Checkout Source') {
      steps {
        git branch: 'main', credentialsId: 'github-credential', url: 'https://github.com/gabryvv/jenkins-kubernetes-deployment.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying React.js container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
        }
      }
    }

  }

}
