#!groovy
@Library('dynamo-workflow-libs') _

pipeline {
  agent none
  options {
    // Only keep the 10 most recent builds
    buildDiscarder(logRotator(numToKeepStr:'10'))
  }
  stages {

    stage ('Start') {
      agent any
      steps {
        sh 'env'
      }
    }

    stage ('Docker Build & Push') {
      agent any
      steps {
        dockerBuildAndPush(env.REGISTRY_SERVER, 'usefdynamo/usef-base')
      }
    }

    stage ("Approval for creating a Docker tag") {
      agent none
      steps {
        timeout(time:5, unit:'DAYS') {
          input "Create a Docker release tag for this image? This will result in a new release tag in the Docker registry."
        }
      }
    }

    stage ('Docker Release') {
      agent any
      steps {
        dockerRelease(env.REGISTRY_SERVER, 'usefdynamo/usef-base', 0.2) //TODO: get latest version from registry and increase by 1 or from property file???
      }
    }

  }
  post {
    failure {
      sendNotifications 'FAILURE'
    }
    unstable {
      sendNotifications 'UNSTABLE'
    }
  }
}
