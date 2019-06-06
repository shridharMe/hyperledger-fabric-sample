pipeline {
    agent {
        node { label 'ecs' }
    }
	environment {        
             
    }
    parameters {
        text(name: 'DOMAIN_NAME', description: 'domain name',defaultValue:'example.com')
    }
    stages {	
     stage("install binaries"){
         steps{             
            sh """               
                chmod +x install_binaries.sh
                ./install_binaries.sh
            """                     
        }  
     }
     stage("generate artifacts"){
         steps{             
            sh """               
                chmod +x generateArtifacts.sh
                ./generateArtifacts.sh
            """                     
        }  
     }
     stage('docker build') { 
            parallel {
                stage('peer') { 
                    steps{
                        dir("fabric-dockers"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -o org1 -p peer0 -m Org1MSP -f peer
                                ./dockerbuild.sh -o org2 -p peer0 -m Org2MSP -f peer
                                ./dockerbuild.sh -o org3 -p peer0 -m Org3MSP -f peer
                                ./dockerbuild.sh -o org4 -p peer0 -m Org4MSP -f peer
                            """                        
                        }
                    }
                }
                stage('cli') { 
                    steps{
                        dir("fabric-dockers"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -o org1 -p peer0 -m Org1MSP -f cli
                            """                        
                        }
                }
                stage('ca') {
                    steps{
                        dir("fabric-dockers"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -o org1 -f ca
                            """                        
                        }
                    }
                }
                stage('orderer') {
                    steps{
                        dir("fabric-dockers"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -or order -f orderer
                            """                        
                        }
                    }
                }
                stage('couchdb') {
                    steps{
                        dir("fabric-dockers"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -f couchdb
                            """                        
                        }
                    }
                }
            }
        } 
	}
    post {
       always {
           script{
                   sh """
                        docker system prune -af
                        docker image prune -af
                    """
           }         
       }    
    }
}
