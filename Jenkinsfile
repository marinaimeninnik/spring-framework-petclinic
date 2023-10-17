pipeline {
    agent {
        label 'ubuntu22_04'
    }

    environment {
    DOCKERHUB_CREDENTIALS = credentials('3fd6e258-dfed-4537-a548-c3272953e573')
    }

    stages {
        stage('Clean workspace') {
            steps {
                deleteDir()
            }
        }
    
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/marinaimeninnik/springcommunity.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    
        stage('Tag and Push') {
            steps {
                script {
                def buildVersion = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                sh "sudo docker tag springcommunity:latest marinaimeninnik/springcommunity:latest"
                sh "sudo docker tag springcommunity:latest marinaimeninnik/springcommunity:${buildVersion}"
                sh "sudo docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW"
                sh "sudo docker push marinaimeninnik/springcommunity:latest"
                sh "sudo docker push marinaimeninnik/springcommunity:${buildVersion}"
                }
            }
            }
        }

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
