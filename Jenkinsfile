pipeline {
  agent any
 
  stages {
    stage('Install sam-cli') {
      steps {        
        sh 'python3.8 -m venv venv && venv/bin/pip3 install aws-sam-cli'
        stash includes: '**/venv/**/*', name: 'venv'
      }
    }
    stage('Build') {

        agent {
                docker { image 'amazon/aws-sam-cli-build-image-python3.8'}
            }
      steps {
        unstash 'venv'
        // sh 'venv/bin/pip3 install aws-sam-cli'
        sh 'sam build'
        stash includes: '**/.aws-sam/**/*', name: 'aws-sam'
      }
    }
  
    stage('prod') {
      environment {
        STACK_NAME = 'sam-app-prod-stage'
        S3_BUCKET = 'si3mshady-prime-devops-bucket'
      }
      steps {
        withAWS(credentials: 'sam-jenkins-credentials', region: 'us-east-2') {
          unstash 'venv'
          unstash 'aws-sam'
          sh 'venv/bin/sam deploy --stack-name $STACK_NAME -t template.yaml --s3-bucket $S3_BUCKET --capabilities CAPABILITY_IAM'
        }
      }
    }
  }
}