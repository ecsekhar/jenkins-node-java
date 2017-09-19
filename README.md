# Description

Jenkins build node for java projects. This project builds a docker image that can be used as build node in Jenkins master. The workflow is:
1. Build the image.
2. Push the image to docker registry.
3. Configure Jenkins master to use the image from the registry as a build node.
4. Configure build jobs to use the new build node.

# Building the Image

## Build
```
./build.sh
```

## Push to Docker registry

Set correct tag in push.sh script and
```
./push.sh
```

# Using the Image

You can find the image from dev-docker-registry.org.com/common/jenkins-node-java.

This image configures maven to use maven-public reposiroty in org Nexus as a proxy repo.

When pushing artifacts to org Nexus you can use tt-nexus as repositoryId in maven deploy plugin.

# Note
org organization
