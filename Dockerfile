#
# This Dockerfile creates a Jenkins build-node for running build jobs in Jenkins for java projects.
#
FROM centos:7.3.1611
MAINTAINER Chandra Sekhar Eswa <e.chandrasekhar@gmail.com>
LABEL openjdk-version="1.8.0_111"
LABEL mvn-version="3.0.5"

# Install and configure packages that are required by jenkins docker plugin.
# Note: Jenkins installs java automatically if it is not found from the image.
# This would slow down the node creation so we install it here. Jenkins satisfies
# with JRE but we install JDK because the application needs it.
RUN yum install -y openssh-server && \
    yum install -y java-1.8.0-openjdk-devel && \
    yum clean all && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    /usr/bin/ssh-keygen -A

# Create Jenkins User
RUN useradd jenkins -m -s /bin/bash && \
    echo "jenkins:jenkins" | chpasswd

# Install packages that are needed by the build jobs
RUN yum install -y git && \
    yum install -y which && \
    yum install -y maven && \
    yum install -y rpm-build && \
    yum clean all

# This will configure maven to use Org Nexus as proxy repo and login to Nexus as ci-nexus-user for pushing artifacts.
COPY maven-settings.xml /home/jenkins/.m2/settings.xml
RUN chown jenkins:jenkins /home/jenkins/.m2 && \
    chown jenkins:jenkins /home/jenkins/.m2/settings.xml

# Expose SSH port and run sshd
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
