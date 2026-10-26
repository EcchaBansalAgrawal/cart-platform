pipeline {
    agent any

    environment {
        IMAGE_NAME = 'retail-cart'
        IMAGE_TAG  = '1.0'
    }

    stages {

        stage('Checkout Repo') {
            steps {
                echo '==> Checking out cart-platform repository'
                checkout scm
                sh 'echo "Workspace: ${WORKSPACE}"'
                sh 'ls -la'
            }
        }

        stage('Run Linter') {
            steps {
                echo '==> Running Python linter (pyflakes)'
                sh '''
                    pip install pyflakes --quiet
                    python -m pyflakes app.py && echo "Lint passed: no issues found"
                '''
            }
        }

        stage('Docker Package') {
            steps {
                echo '==> Building Docker image retail-cart:1.0'
                sh '''
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    echo "Image built successfully:"
                    docker images ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

    }

    post {
        success {
            echo 'Pipeline completed successfully – retail-cart:1.0 is ready.'
        }
        failure {
            echo 'Pipeline failed. Check stage logs above.'
        }
    }
}
