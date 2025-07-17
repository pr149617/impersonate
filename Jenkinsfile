pipeline {
    agent any

    environment {
        PROJECT_ID = 'canvas-primacy-466005-f9'      // Your GCP project ID
        IMPERSONATE_ACCOUNT = 'terraform-svc@canvas-primacy-466005-f9.iam.gserviceaccount.com'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Authenticate Jenkins to GCP') {
             steps {
                withCredentials([file(credentialsId: 'jenkinssvckey', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                 bat '''
                     gcloud auth activate-service-account --key-file=%GOOGLE_APPLICATION_CREDENTIALS%
                     gcloud config set project canvas-primacy-466005-f9
                     echo Authenticated Jenkins runner to GCP using impersonation
                     gcloud auth list
                '''
        }
    }
}

        stage('Terraform Init') {
            steps {
                bat '''
                    terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                bat '''
                    terraform plan -out=tfplan.out
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Apply Terraform changes?"
                bat '''
                    terraform apply -auto-approve tfplan.out
                '''
            }
        }
    }

    post {
        always {
            echo 'Terraform pipeline completed'
        }
    }
}
