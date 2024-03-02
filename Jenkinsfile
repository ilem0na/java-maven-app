def gv

pipeline {
    agent any
    environment {
        ANSIBLE_SERVER = "159.223.195.227"
    }
    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copying all necessary files to ansible control server..."
                    sshagent(['ansible-server-key']) {
                        sh "scp -o strictHostkeyChecking=no ansible/* root@${ANSIBLE_SERVER}:/root"

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-aserver-key', keyFileVariable: 'keyfile', usernameVaraible: 'user')]) {
                        
                        sh 'scp $keyfile root@$ANSIBLE_SERVER:/root/Downloads/ansible_keypair.pem'
                        }
                    }
                }
            }
        } 

        stage("execute ansible playbook") {
            steps {
                script {
                    echo "calling ansible playbook to configure ec2 instances"
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = ANSIBLE_SERVER
                    remote.allowAnyHosts = true

                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]){
                        remote.user = user
                        remote.identityFile = keyfile
                        //sshCommand remote: remote, command: "chmod 744 /etc/ansible/hosts"
                        sshCommand remote: remote, command: "ansible-playbook my-playbook.yaml"
                    }
                }
            }
        }
    }

}
