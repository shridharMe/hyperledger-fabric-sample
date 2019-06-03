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
                        dir("peer"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -o org1 -p peer0 -m Org1MSP
                                ./dockerbuild.sh -o org2 -p peer0 -m Org2MSP
                                ./dockerbuild.sh -o org3 -p peer0 -m Org3MSP
                                ./dockerbuild.sh -o org4 -p peer0 -m Org4MSP
                            """                        
                        }
                    }
                }
                stage('cli') { 
                    steps{
                        dir("cli"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -o org1 -p peer0 -m Org1MSP
                            """                        
                        }
                }
                stage('ca') {
                    steps{
                        dir("ca"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -o org1
                            """                        
                        }
                    }
                }
                stage('orderer') {
                    steps{
                        dir("orderer"){
                            sh """               
                                chmod +x dockerbuild.sh
                                ./dockerbuild.sh -o org1
                            """                        
                        }
                    }
                }
                stage('coucdb') {
                    steps{
                        sh """               
                            chmod +x generateArtifacts.sh
                            ./generateArtifacts.sh
                        """
                    }
                }
            }
        } 
	}
    post {
       always {
           script{
                 sh '''
                    
                 '''
           }         
       }    
    }
}
