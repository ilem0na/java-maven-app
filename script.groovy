#!/usr/bin/env groovy
def buildJar() {
    echo "Building jar..."
    sh 'mvn package'
}

def buildImage() {
    echo "Building image..."
    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t ilemona02/java-napp:jma-2.0 .'
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh 'docker push ilemona02/java-napp:jma-2.0'
    }
}

def deployApp() {
    echo "Deploying app..."
}

return this