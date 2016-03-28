FROM centos:centos6

USER root

WORKDIR /

#安装yum源   mysql nginx php
ADD ./tools/yum.repos.d/* /etc/yum.repos.d/
ADD ./tools/rpm-gpg/* /etc/pki/rpm-gpg/
RUN rpm -Uvh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN rpm -ivh http://mirrors.aliyun.com/epel/epel-release-latest-6.noarch.rpm

## 创建开发用户
RUN useradd dev -u 1000
RUN echo "plk789" | passwd --stdin "dev"

#安装ssh
RUN yum install openssh-server postfix cronie -y

### etc
## set timezone
RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "plk789" | passwd --stdin "root"

### 执行服务
RUN service postfix start 
RUN chkconfig postfix on

RUN curl -O https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-7.7.2_omnibus.5.4.2.ci-1.el6.x86_64.rpm
RUN sudo rpm -i gitlab-7.7.2_omnibus.5.4.2.ci-1.el6.x86_64.rpm

RUN sudo gitlab-ctl reconfigure 
RUN sudo lokkit -s http -s ssh

### main
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/bin/bash", "/start.sh"]

EXPOSE 22
EXPOSE 80