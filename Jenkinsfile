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
    }
}