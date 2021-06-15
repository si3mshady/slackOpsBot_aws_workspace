pipeline {
  agent any

  stages {
    stage("build") {
      steps {
        echo 'building the application...'
        echo 'Jenkins training with Nana'
        echo 'Web hook has been configured'
        
        script {
            def test = 2 + 2 > 100? 'Cool!': 'Not Cool'
        }
      }
    }

    stage("test") {
      steps {
        echo 'testing the application...'
         echo 'Practicing Jenkinsfile config!'
      }
    }

    stage("deploy") {
      steps {
         echo 'deploying the application...'
      }
    }
  }
}