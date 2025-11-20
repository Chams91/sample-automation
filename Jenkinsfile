pipeline {
    agent any
    
    // environment {
    //     DOCKER_IMAGE = "your-dockerhub-username/hello-world-app"
    //     DOCKER_TAG = "${env.BUILD_ID}"
    //     DOCKER_REGISTRY_CREDENTIALS = 'dockerhub-credentials'
    // }
    
    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out source code from repository..."
                checkout scm
            }
        }
        
        stage('Setup Dependencies') {
            steps {
                echo "Installing dependencies and building application..."
                sh 'mvn clean compile'
            }
        }
        
        // stage('Build Docker Image') {
        //     steps {
        //         echo "Building Docker image..."
        //         sh 'mvn package -DskipTests'
        //         sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
        //     }
        // }
        
        // stage('Run App with Docker') {
        //     steps {
        //         echo "Starting application in Docker container..."
        //         script {
        //             // Stop and remove any existing container
        //             sh 'docker stop hello-app || true'
        //             sh 'docker rm hello-app || true'
        //             // Run new container
        //             sh "docker run -d -p 8080:8080 --name hello-app ${DOCKER_IMAGE}:${DOCKER_TAG}"
        //             // Wait for app to start
        //             sleep 30
        //         }
        //     }
        // }
        
        // stage('Run Smoke Tests') {
        //     steps {
        //         echo "Running smoke tests on deployed application..."
        //         sh 'chmod +x smoke-test.sh'
        //         sh './smoke-test.sh'
        //     }
            
        //     post {
        //         always {
        //             echo "Cleaning up test container..."
        //             sh 'docker stop hello-app || true'
        //             sh 'docker rm hello-app || true'
        //         }
        //     }
        // }
        
        // stage('Push to DockerHub') {
        //     steps {
        //         echo "Pushing image to DockerHub registry..."
        //         withCredentials([usernamePassword(
        //             credentialsId: env.DOCKER_REGISTRY_CREDENTIALS,
        //             usernameVariable: 'DOCKER_USERNAME',
        //             passwordVariable: 'DOCKER_PASSWORD'
        //         )]) {
        //             sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
        //             sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
        //         }
        //     }
        // }
    }
    
    post {
        always {
            echo "Pipeline execution completed - cleaning up..."
            // sh 'docker stop hello-app || true'
            // sh 'docker rm hello-app || true'
        }
        success {
            echo "✓✓✓ Pipeline executed successfully! ✓✓✓"
            //echo "Docker image pushed: ${DOCKER_IMAGE}:${DOCKER_TAG}"
        }
        failure {
            echo "!!! Pipeline failed !!!"
        }
    }
}