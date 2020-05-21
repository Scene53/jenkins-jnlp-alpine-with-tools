FROM centos:7
USER root
RUN yum -y update && yum --enablerepo=base clean metadata
RUN yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel git
RUN yum clean all

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group}
RUN useradd -c "Jenkins user" -d /home/${user} -u ${uid} -g ${gid} -m ${user}
LABEL Description="This is a base image for centos 7 based Jenkins JNLP slave"

ARG AGENT_WORKDIR=/home/${user}/agent
RUN mkdir -p /usr/share/jenkins

COPY remoting-4.3.jar /usr/share/jenkins/slave.jar
RUN  chmod 755 /usr/share/jenkins && chmod 644 /usr/share/jenkins/slave.jar
COPY jenkins-slave /usr/local/bin/jenkins-agent
RUN chmod a+x /usr/local/bin/jenkins-agent

ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}

USER ${user}

ENTRYPOINT ["jenkins-agent"]
