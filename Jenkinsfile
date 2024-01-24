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
                    env.IMAGE_NAME = "$version-BUILD_NUMBER"
                    
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
                    buildImage "ilemona02/my-nrepo:${IMAGE_NAME} ."
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
                    
                }
            }
        }
    }
}
