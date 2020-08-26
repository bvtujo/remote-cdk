# remote-cdk
A collection of utilities for building and developing with the AWS CDK inside a docker container.
## About the Docker Image
You can fetch this image with the following command: 
```sh
$ docker pull austiely/remote-cdk:latest
```
There are also versions tagged with the Git commit SHA that it was built from. No guarantees that your preferred commit is in there, though, as this runs on a schedule and is not triggered by the CDK repository's releases or pushes to master.

### Caveats
* Not every commit is represented in the repository. You may have to clone the latest, then run `git pull` from inside the container and do a `buildup` on your preferred package.
* This project packages all of the generated javascript and definition files as part of the image. That means that it uses container storage as a side effect of its portability, and you'll have to use git from inside the container if you want to contribute. Some instructions on doing that follow below in the **Git Setup**.

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

If the container ever gets killed and you need to restart it, 

```sh
$ docker start containerized_cdk
```

### Git Setup
You probably want to use Git from inside this container. That means you'll need to get an SSH key with push access to your Github account into your container. You can do this in a couple of ways.

Probably the easiest is to generate a new SSH key that's only used inside of the container and allow it to access your Github account. That way you can easily revoke access if the host the container is running on is compromised or you accidentally distribute your SSH key as a layer in a Docker image. 

#### Create an SSH key inside the container
From a terminal attached to the container:

```sh
$ ssh-keygen -f ~/.ssh/id_rsa_cdk -N `cat secret_passphrase.txt`
$ eval `ssh-agent`
$ ssh-add ~/.ssh/id_rsa_cdk
```

#### Add the SSH key to your Github account
Navigate to the [New SSH Key page](https://github.com/settings/ssh/new) on github. Create a title for your key and copy the contents of `~/.ssh/id_rsa_cdk.pub` into the key text box. 

You should now be able to access your Github account from the container. 

### Visual Studio Code
To use VSCode with your new development container, do the following:
1. Download the Remote Containers VSCode extension
1. Using the command palette (cmd+shift+P), run "Remote Containers: Attach to a running container"
1. Find "containerized_cdk" in the list. 

You should now be able to browse the filesystem. 
