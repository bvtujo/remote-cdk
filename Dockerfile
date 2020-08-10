FROM jsii/superchain
WORKDIR src
COPY aws-cdk .
RUN yum install wget -y
RUN sh -c "$(wget https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
