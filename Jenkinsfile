pipeline {
  agent any
  options { timestamps(); disableConcurrentBuilds(); skipDefaultCheckout() }
  environment { AWS_REGION='ap-south-1'; ECR_REPOSITORY='complete-java-application' }
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Validate') { steps { sh 'bash ci/test.sh && bash scripts/validate.sh' } }
    stage('Trivy filesystem') { steps { sh 'bash ci/trivy-fs-scan.sh' } }
    stage('SonarQube') { steps { withSonarQubeEnv('sonarqube') { sh 'sonar-scanner' } } }
    stage('Quality Gate') { steps { timeout(time: 10, unit: 'MINUTES') { waitForQualityGate abortPipeline: true } } }
    stage('Docker build') { steps { sh 'docker build -t complete-java-application:$BUILD_NUMBER .' } }
    stage('Trivy image') { steps { sh 'bash ci/trivy-image-scan.sh complete-java-application:$BUILD_NUMBER' } }
    stage('Publish DEV artifact') {
      when { allOf { branch 'dev'; not { changeRequest() } } }
      steps { sh 'bash ci/push-ecr.sh complete-java-application:$BUILD_NUMBER && bash ci/record-digest.sh' }
    }
  }
  post {
    success { archiveArtifacts artifacts: 'image-digest.txt', allowEmptyArchive: true }
  }
}
