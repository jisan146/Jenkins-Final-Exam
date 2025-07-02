pipeline {
    agent any

    parameters {
        string(name: 'BUILD_VERSION', defaultValue: 'latest', description: 'Version tag for the Docker image')
    }

    environment {
        GITHUB_CREDENTIALS = credentials('jisan-ID')  // GitHub credentials ID
        DOCKERHUB_CREDENTIALS = credentials('jisan-pass')  // Docker Hub credentials ID
    }

    stages {
        stage('Pull Demo Code from GitHub') {
            steps {
                script {
                    echo "Starting the build for version: ${params.BUILD_VERSION}"
                    git credentialsId: "${GITHUB_CREDENTIALS}", url: 'https://github.com/jisan146/clean-arch-dot-net.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image with tag: ${params.BUILD_VERSION}"
                    sh '''
                    docker build -t jisan146/clean-arch:${params.BUILD_VERSION} .
                    '''
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    echo "Pushing Docker image to Docker Hub"

                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push jisan146/clean-arch:${params.BUILD_VERSION}
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline successfully completed"
        }

        failure {
            echo "Pipeline failed"
        }
    }
}
