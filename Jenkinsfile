pipeline {

    agent any

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/chandra9523/random_forest-cicd.git'
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                docker run --rm -v $(pwd):/app -w /app python:3.10 \
                sh -c "pip install -r requirements.txt && pytest"
                '''
            }
        }

        stage('Train Model') {
            steps {
                sh '''
                docker run --rm -v $(pwd):/app -w /app python:3.10 \
                sh -c "pip install -r requirements.txt && python train.py"
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t cbdocker2525/ml-cicd:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push cbdocker2525/ml-cicd:latest'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f ml-container || true
                docker run -d -p 5000:5000 --name ml-container cbdocker2525/first-cicd:latest
                '''
            }
        }
    }
}