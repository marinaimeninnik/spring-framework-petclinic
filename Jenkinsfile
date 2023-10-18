pipeline {
    agent {
        label 'ubuntu22_04'
    }

    environment {
    DOCKERHUB_CREDENTIALS = credentials('3fd6e258-dfed-4537-a548-c3272953e573')
    BUILD_VERSION = sh(script: 'echo $((BUILD_NUMBER + 0))', returnStatus: true).trim()
    IMAGE_NAME = 'springcommunity/spring-framework-petclinic'
    LATEST_TAG = 'latest'

    }

    stages {
        stage('Clean workspace') {
            steps {
                deleteDir()
            }
        }
    
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/marinaimeninnik/spring-framework-petclinic.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // sh 'mvn clean package'
                script {
                // Build the Docker image and tag it with the build version
                sh "mvn clean package jib:dockerBuild -Djib.image=${IMAGE_NAME}:${BUILD_VERSION}"
                
                // Use Docker command to get the name of the last created container
                def containerName = sh(script: "docker ps -l -q --format '{{.Names}}'", returnStdout: true).trim()
                
                echo "The name of the last created container is: $containerName"
                
                // Now you can use the 'containerName' variable in subsequent stages or steps
            }
            }
        }
    
        // stage('Tag and Push') {
        //     steps {
        //         // script {
        //         // def buildVersion = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        //         // sh "sudo docker tag docker.io/springcommunity/spring-framework-petclinic:latest marinaimeninnik/docker.io/springcommunity/spring-framework-petclinic:latest"
        //         // sh "sudo docker tag docker.io/springcommunity/spring-framework-petclinic:latest marinaimeninnik/docker.io/springcommunity/spring-framework-petclinic:${buildVersion}"
        //         // sh "sudo docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW"
        //         // sh "sudo docker push marinaimeninnik/docker.io/springcommunity/spring-framework-petclinic:latest"
        //         // sh "sudo docker push marinaimeninnik/docker.io/springcommunity/spring-framework-petclinic:${buildVersion}"
        //         // }
        //         // sh 'mvn jib:build'
        //     }
        //     }
        // }

        post {
            always {
            sh 'docker logout'
            }

        // stage('Build and Push Docker Image') {
        //     steps {
        //         script {
        //             // Define Docker image name and tags
        //             def dockerImageName = "your-docker-image"
        //             def versionTag = "1.0" // Change this to your desired version

        //             // Set Docker Hub credentials
        //             withCredentials([usernamePassword(credentialsId: '3fd6e258-dfed-4537-a548-c3272953e573', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
        //                 sh "mvn jib:build -Dimage=${dockerImageName}:latest"
        //                 sh "mvn jib:build -Dimage=${dockerImageName}:${versionTag}"
        //             }
        //         }
        //     }
        // }
        }
    }
}
