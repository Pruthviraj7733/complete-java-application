pipeline {
 agent any
 options { timestamps(); disableConcurrentBuilds() }
 stages {
  stage('Checkout') { steps { checkout scm } }
  stage('Validate') { steps { sh 'bash ci/test.sh' } }
  stage('Trivy source') { steps { sh 'bash ci/trivy-fs-scan.sh' } }
  stage('SonarQube') { steps { withSonarQubeEnv('sonarqube') { sh 'sonar-scanner' } } }
  stage('Quality Gate') { steps { timeout(time: 10, unit: 'MINUTES') { waitForQualityGate abortPipeline: true } } }
  stage('Build') { steps { sh 'docker build -t complete-java-application:$BUILD_NUMBER .' } }
  stage('Trivy image') { steps { sh 'bash ci/trivy-image-scan.sh complete-java-application:$BUILD_NUMBER' } }
  stage('ECR push') { when { branch 'dev' } steps { sh 'bash ci/push-ecr.sh complete-java-application:$BUILD_NUMBER' } }
 }
}
