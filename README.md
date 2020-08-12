# remote-cdk
A collection of utilities for building and developing with the AWS CDK on a remote host
## Usage
To mount your local git and aws config files and launch the container, run the following:
```sh
$ docker run -d -it --name containerized_cdk \
  -v ~/.gitconfig:/etc/gitconfig \
  -v ~/.aws:/root/.aws \
  -v ${AWS_CDK_REPO}/.git/config:/root/aws-cdk/.git/config \
  austiely/remote-cdk:latest
```

You can then use your preferred build environment to attach a terminal to the container.

```sh
$ docker attach containerized_cdk
```

### Visual Studio Code
To use VSCode with your new development container, do the following:
1. Download the Remote Containers VSCode extension
1. Using the command palette (cmd+shift+P), run "Remote Containers: Attach to a running container"
1. Find "containerized_cdk" in the list. 

You should now be able to browse the filesystem. 
