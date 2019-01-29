pipeline {
  environment {
    registry = "yurgent/epam"
    registryCredential = 'docker-cred'
    dockerImage = ''
  }
  agent { 
     node { 
        label 'jenkins_agent' 
          } 
        } 
   stages {
    stage ('Python tests') {
     steps {
        sh """
           python3 -m venv venv
           . venv/bin/activate
           pip install -e .
           export FLASK_APP=js_example
           pip install -e '.[test]'
           coverage run -m pytest
           coverage report
           deactivate
           """
           }
      }
     stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":web_app_from_jenkins:$BUILD_NUMBER"
        }
      }
    }
     stage('Deploy image'){
       steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
         }
       }
     }
   }
}
