pipeline {
     agent {
        label 'ubuntu22_04'
    }


    stages {
        stage('Checkout') {
            steps {
                withCredentials([usernamePassword(credentialsId: '5f407016-3f8c-4868-8f54-e2e660c91a3c', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                // Checkout your source code from your version control system
                // For example, using Git:
                    git 'https://github.com/marinaimeninnik/spring-framework-petclinic.git'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Define Docker image name and tags
                    def dockerImageName = "your-docker-image"
                    def versionTag = "1.0" // Change this to your desired version

                    // Set Docker Hub credentials
                    withCredentials([usernamePassword(credentialsId: '3fd6e258-dfed-4537-a548-c3272953e573', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "mvn jib:build -Dimage=${dockerImageName}:latest"
                        sh "mvn jib:build -Dimage=${dockerImageName}:${versionTag}"
                    }
                }
            }
        }
    }
}
