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
    environment {
        
        IMAGE_REPO = '530182258888.dkr.ecr.us-east-2.amazonaws.com/si3mshady-projects'
      }
      
      steps {
        unstash 'venv'
         sh 'venv/bin/sam build'
         sh 'venv/bin/sam package --s3-bucket $S3_BUCKET --output-template-file=packaged.yaml --image-repository=$IMAGE_REPO --region=us-east-2'

        stash includes: '**/.aws-sam/**/*', name: 'aws-sam'
      }
    }
  
    stage('prod') {
      environment {
        STACK_NAME = 'sam-app-prod-stage'
        S3_BUCKET = 'another-devops-bucket'
        IMAGE_REPO = '530182258888.dkr.ecr.us-east-2.amazonaws.com/si3mshady-projects'
      }
      steps {
        withAWS(credentials: 'sam-jenkins-credentials', region: 'us-east-2') {
          unstash 'venv'
          unstash 'aws-sam'         
          sh 'venv/bin/sam deploy --template-file packaged.yaml --stack-name $STACK_NAME  --capabilities CAPABILITY_IAM --image-repository $IMAGE_REPO  --parameter-overrides SlackSigningSecret=toil  SlackBotToken=toil'
        }
      }
    }
  }
}