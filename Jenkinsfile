#!/usr/bin/env groovy
@Library('jenkins-shared-library')
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
                    buildJar()
            }
        }
        stage('build image') {
            steps {
                script {
                    echo "building jar"
                    //gv.buildJar()
                }
            }
        }
        stage('test') {
            steps {
                script {
                    echo "building image"
                    //gv.buildImage()
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo "deploying"
                    //gv.deployApp()
                }
            }
        }
    }
}
