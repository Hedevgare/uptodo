pipeline {
    agent any

    environment {
        REMOTE_USER = credentials('VPS-Username')
        REMOTE_HOST = credentials('VPS-IP')
        REMOTE_PATH = "/var/www/html/appstore/files"
        SSH_CRED_ID = "VPS-Key"
    }

    stages {
        stage("Install Dependencies") {
            steps {
                bat """
                flutter pub get
                """
            }
        }

        stage("Clear Old Builds") {
            steps {
                powershell """
                Remove-Item -Path "build\\app\\outputs\\flutter-apk\\*" -Recurse -Force -ErrorAction SilentlyContinue
                """
            }
        }

        stage("Build") {
            steps {
                bat """
                flutter build apk --release
                """
            }
        }

        stage("Rename APK") {
            steps {
                powershell """
                $version = ((Get-Content pubspec.yaml) -match '^version:')[0].Split(" ")[1].Trim()
                Move-Item -Path "build\\app\\outputs\\flutter-apk\\app-release.apk" -Destination "build\\app\\outputs\\flutter-apk\\uptodo-$version.apk"
                """
            }
        }

        stage("Deploy") {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: env.SSH_CRED_ID, keyFileVariable: 'SSH_KEY')]) {
                    bat '''
                    scp -i %SSH_KEY% -r build\\app\\outputs\\flutter-apk\\uptodo-* %REMOTE_USER%@%REMOTE_HOST%:%REMOTE_PATH%
                    '''
                }
            }
        }
    }
}