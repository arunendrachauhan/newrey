#!/bin/bash
set -e

if [ "${1:0:1}" != '-' ]; then
	exec "$@"
fi
SONARQUBE_JDBC_URL="jdbc:postgresql://sonardb:5432/sonar"
SONARQUBE_JDBC_USERNAME="sonar"
SONARQUBE_JDBC_PASSWORD="sonar"
exec java -jar lib/sonar-application-$SONAR_VERSION.jar \
	-Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
	-Dsonar.web.host="0.0.0.0" \
	-Dsonar.web.port="9000" \
	-Dsonar.web.context="/sonar" \
  -Dsonar.web.javaAdditionalOpts="-server" \
	"$@"
