FROM jsii/superchain
WORKDIR /root/aws-cdk
COPY aws-cdk .
RUN yum install wget -y
RUN sh -c "$(wget https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
ENTRYPOINT ["tail", "-f", "/dev/null"]
