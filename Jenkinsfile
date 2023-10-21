pipeline {
    agent {
        label 'ubuntu22_04'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('3fd6e258-dfed-4537-a548-c3272953e573')
        BUILD_VERSION = sh(script: 'echo $((BUILD_NUMBER + 0))', returnStatus: true)
        IMAGE_NAME = 'marinaimeninnik/spring-framework-petclinic'
        LATEST_TAG = 'latest'

    }

    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
    
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/marinaimeninnik/spring-framework-petclinic.git'
            }
        }

        stage('Scan with SonarQube') {
            steps {
                withSonarQubeEnv(installationName: 'SQ') { 
                    sh 'mvn clean package org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                }
            }
        }

        stage('Build Docker Image') {
            steps {                
                script {
                    sh "mvn clean package jib:dockerBuild -Djib.image=${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Tag and Push') {
            steps {
                script {
                    def buildVersion = "1.0.${env.BUILD_NUMBER}"
                    sh "sudo docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${buildVersion}"
                    
                    withCredentials([usernamePassword(credentialsId: '3fd6e258-dfed-4537-a548-c3272953e573', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                        sh "sudo docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW"
                        sh "sudo docker push ${IMAGE_NAME}:${buildVersion}"
                        sh "sudo docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
   
    post {
        always {
        sh 'docker logout'
        }
    }
}

   

