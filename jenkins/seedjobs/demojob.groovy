def gitUrl = 'arunendrachauhan/newrey'

createPipelineJob ("MyDemo", gitUrl, "jenkins/Jenkinsfile")
def createPipelineJob (def jobName, def gitHubUrl, def scriptFilePath){
pipelineJob( jobName ) {
	description()
	keepDependencies(false)
	definition {
		cpsScm {
			scm {
				git {
					remote {
						github(gitHubUrl, "https")

					}
					branch("*/master")
				}
			}
			scriptPath(scriptFilePath)
		}
	}
	disabled(false)
	configure {
		it / 'properties' / 'com.coravy.hudson.plugins.github.GithubProjectProperty' {
			'projectUrl'('https://github.globant.com/arunendra-chauhan/devopsquest4.git/')
			displayName("DEMO")
		}
	}
}
}
