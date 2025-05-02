Pipeline script from SCM
SCM: Git
Repository URL: https://github.com/VDianez/simple-python-pyinstaller-app
Credentials: <None>
Script Path: Jenkinsfile
Branches to build: */main
pipeline {
    agent {
        docker {
            image 'python:3.13-alpine'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        APP_NAME = 'simple-python-pyinstaller-app'
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh 'pip install --upgrade pip'
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Build executable') {
            steps {
                sh 'pyinstaller --onefile main.py'
            }
        }
        stage('Run tests') {
            steps {
                sh 'pytest tests'
            }
        }
        stage('Deliver') {
            steps {
                sh './jenkins/scripts/deliver.sh'
                input message: '¿Terminaste de usar la aplicación? Haz clic en "Proceed" para continuar.'
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}