pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "sunnychams/spring-basic"
        DOCKER_TAG = "${env.BUILD_ID}"
        DOCKER_REGISTRY_CREDENTIALS = 'dockerhub-credentials'
    }

    tools {
        maven 'maven'  // This must match the name in Jenkins Tools
    }
    
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

        stage('Verify Environment') {
            steps {
                sh '''
                    echo "Home: $HOME"
                    echo "User: $(whoami)"
                    echo "Docker Host: $DOCKER_HOST"
                    colima status || echo "Colima not running"
                    docker version || echo "Docker not accessible"
                '''
            }
        }
        
        stage('Start Colima if Needed') {
            steps {
                sh '''
                    if ! colima status 2>/dev/null; then
                        echo "🔧 Starting Colima..."
                        colima start
                        sleep 10
                    else
                        echo "✅ Colima is running"
                    fi
                    
                    # Verify Docker works
                    docker ps && echo "✅ Docker is working" || echo "❌ Docker not working"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'mvn package -DskipTests'
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        
        // stage('Run App with Docker') {
        //     steps {
        //         echo "Starting application in Docker container..."
        //         script {
        //             // Stop and remove any existing container
        //             sh 'docker stop basic-spring-app || true'
        //             sh 'docker rm basic-spring-app || true'
        //             // Run new container
        //             sh "docker run -d -p 8088:8080 --name basic-spring-app ${DOCKER_IMAGE}:${DOCKER_TAG}"
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
            // sh 'docker stop basic-spring-app || true'
            // sh 'docker rm basic-spring-app || true'
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