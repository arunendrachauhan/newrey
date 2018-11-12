def gitUrl = 'https://github.com/arunendrachauhan/newrey'
def host = '$(hostname -I | cut -f2 -d' ')'
createPipelineJob("MyDemotest", gitUrl, "jenkins/Jenkinsfile")

def createPipelineJob(def jobName, def gitUrl, def scriptPath) {
  job("${jobName}") {
    parameters {
      stringParam("BRANCH", "master", "Define TAG or BRANCH to build from")
      stringParam("REPOSITORY_URL", "http://${host}:8081/repository/maven-releases/", "Nexus Release Repository URL")
    }
    scm {
      git {
        remote {
          url(gitUrl)
        }
        extensions {
          cleanAfterCheckout()
        }
      }
    }
    triggers {
      scm('30/H * * * *')
      githubPush()
    }
    pipeline {
      scm {
        git {
          remote {
            url(gitUrl)
            }
          }
        branches {
          git {
            name('*/master')
            }
          }
        }
        scriptPath(scriptPath)
    }
buildPipelineView('Demo Pipeline View') {
    filterBuildQueue()
    filterExecutors()
    title('Demo')
    displayedBuilds(5)
    selectedJob("")
    alwaysAllowManualTrigger()
    refreshFrequency(60)
}

listView('Demo List View') {
    description('')
    filterBuildQueue()
    filterExecutors()
    jobs {
        regex(/*.*/)
    }
    columns {
        status()
        buildButton()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
    }
}
