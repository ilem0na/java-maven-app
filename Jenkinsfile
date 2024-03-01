def gv

pipeline {
    agent any
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copying all necessary files to ansible control server..."
                    sshagent(['ansible-server-key']) {
                        sh "scp -o strictHostkeyChecking=no ansible/* root@159.223.195.227:/root"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-aserver-key', keyFileVariable: 'keyfile', usernameVaraible: 'user')]) {
                        
                        sh 'scp $keyfile root@159.223.195.227:/root/ansible_keypair.pem'
                        }
                    }
                }
            }
        } 

        stage("configure web server") {
            steps{
                script {
                    echo " calling ansible playbook to configure the web server on AWS EC2 instance"

                    def remote = [:]
                    remote.name = 'ansible-server'
                    remote.host = '159.223.195.227'
                    remote.allowAnyHosts = true

                    withCredentials([sshUserPrivateKey(credentialsId: ansible-server-key, keyFileVariable: 'keyfile', usernameVariable: 'ansible-server')]) {
                        remote.user = ansible-server
                        remote.identityFile = keyfile
                        sshCommand remote: remote, command: "ls -la"
                    }
                    
                }
            }
        }
    }
}