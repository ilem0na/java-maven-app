#!/usr/bin/env groovy
def gv
pipeline {
    agent any
    tools {
        maven 'maven-3.9.6'
    }
    stages {
        stage('init') {
            steps {
                script {
                    echo "Initializing..."
                    gv = load 'script.groovy'
                }
            }
        }
        stage('build jar') {
            steps {
                script {
                    echo "Building the jar with external groovy script..."
                    sh 'mvn package'
                }
            }
        }
        stage('build image') {
            steps {
                script {
                    echo "Building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t ilemona02/java-napp:jma-2.0 .'
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh 'docker push ilemona02/java-napp:jma-2.0'
    }
}
            }
        }
        stage('test') {
            steps {
                script {
                    echo "Testing the application..."
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo "Deploying the application..."
                }
            }
        }
    }
}

