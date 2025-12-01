pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "mohammedalianis"
        IMAGE_NAME     = "vaks-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Maven Build') {
            steps {
                sh "mvn clean package -DskipTests"
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'TOKEN')]) {
                    sh """
                        echo "$TOKEN" | docker login -u ${DOCKERHUB_USER} --password-stdin
                    """
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh "docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
            }
        }
    }
}
