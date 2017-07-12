#!groovy
@Library('dynamo-workflow-libs') _

pipeline {
  agent none
  environment {
    DOCKER_IMAGE = 'usefdynamo/usef-base'
    DOCKER_IMAGE_RELEASE_TAG = '0.4' //TODO: get latest version from registry and increase by 1 or from property file???
  }
  options {
    // Only keep the 10 most recent builds
    buildDiscarder(logRotator(numToKeepStr:'10'))
  }
  stages {

    stage ('Start') {
      agent any
      steps {
        script {
          env.BRANCH_NAME = env.BRANCH_NAME?.replaceAll("origin/", "")?.replaceAll("/", "_")
          env.DOCKER_IMAGE_CI_TAG = env.BRANCH_NAME == "master"? env.BUILD_TIMESTAMP : env.BRANCH_NAME + "-" + env.BUILD_TIMESTAMP
        }
        sh 'env'
      }
    }

    stage ('Docker CI') {
      agent any
      steps {
        dockerBuildAndPush(env.DOCKER_IMAGE, env.DOCKER_IMAGE_CI_TAG)
      }
    }

    stage ("Approval for creating a Docker release tag") {
      agent none
      steps {
        timeout(time:1, unit:'DAYS') {
          input "Create a Docker release tag for this image? This will result in a new release tag in the Docker registry."
        }
      }
    }

    stage ('Docker Release') {
      agent any
      steps {
        dockerBuildAndPush(env.DOCKER_IMAGE, env.DOCKER_IMAGE_RELEASE_TAG)
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
