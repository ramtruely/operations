# from the project root (pom.xml + assembly.xml present)
mvn -s /root/.m2/settings.xml -B clean package deploy
Just for testing the trails of Triggering

------

pipeline {
    agent any

    stages {

        stage('Download ZIP from Nexus') {
            steps {
                sh '''
                    echo "Downloading ZIP from Nexus..."
                    curl -u admin:admin \
                         -L https://nexus.example.com/repository/my-repo/my-app-1.0.zip \
                         -o my-app.zip
                '''
            }
        }

        stage('Unzip ZIP') {
            steps {
                sh '''
                    echo "Unzipping artifact..."
                    unzip -o my-app.zip -d extracted
                '''
            }
        }
    }
}

