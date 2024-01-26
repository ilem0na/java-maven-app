#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
    [$class: 'GitSCMSource',
     remote: 'https://github.com/ilem0na/jenkins-shared-library.git', credentialsID: 'github-credentials']
     )
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
        stage('Increment version') {
            steps {
                script {
                    echo "Incrementing the version..."
                    sh "mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} versions:commit"
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    echo "Version: ${version}"
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                    
                }
            }
        }
        stage('build jar') {
            steps {
                script {
                    echo "Building the jar with external groovy script..."
                    buildJar()
                }
            }
        }

        stage('build and push image') {
            steps {
                script {
                    echo "Building the docker image..."
                    buildImage "ilemona02/my-nrepo:${IMAGE_NAME}"
                    dockerLogin()
                    dockerPush("ilemona02/my-nrepo:${IMAGE_NAME}")
                }
            }
        }
        stage('test') {
            steps {
                script {
                    echo "Testing the application..."
                    echo "Testing webhook from github..."
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo "Deploying the application..."
                    def dockerCmd = "docker run -dp 8080:8080 ilemona02/my-nrepo:${IMAGE_NAME}"
                    def ec2Instance = "ec2-user@18.206.248.121"
                    sshagent(['Server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${dockerCmd}"        

                    }
                    
                }
            }
        }
        stage('deploy to EKS') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
            }
            steps {
                script {
                    echo "Deploying the application to EKS..."
                    sh "kubectl create deployment javaApp-deployment --image=ilemona02/my-nrepo:${IMAGE_NAME}"
                  
                }
            }
        }
        stage('Commit Version update') {
            steps {
                script {
                  withCredentials([string(credentialsId: 'github-AT', variable: 'TOKEN')]) {
                    sh 'git config --global user.email "Jenkins-ci@example.com"'
                    sh 'git config --global user.name "Jenkins CI"'
                    sh 'git status'
                    sh 'git branch'
                    sh 'git config --list'
                    sh "git remote set-url origin https://${TOKEN}@github.com/ilem0na/java-maven-app.git"
                    sh "git add ."
                    sh "git commit -m 'Increment version in pom.xml from jenkins'"
                    sh "git push origin HEAD:jenkins-shared-lib "
                    } 
                }
            }
        }
    }
}
