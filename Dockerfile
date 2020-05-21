FROM jenkins/inbound-agent
MAINTAINER Ofer Rubin. <oferr@playstudios-il.com>


USER root
WORKDIR /
RUN apt-get update && apt-get install uuid-runtime


USER jenkins

ENTRYPOINT ["jenkins-agent"]
