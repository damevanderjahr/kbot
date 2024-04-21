pipeline {
    agent any
    parameters {

        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')

        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Pick Arch')

    }
    stages {
        stage('Example') {
            steps {
                echo "Build for platform ${params.OS}"

                echo "Build for arch: ${params.ARCH}"

                sh 'make TARGETOS=${params.OS} TARGETARCH=${params.ARCH} build'

            }
        }
    }
}