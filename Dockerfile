# Run Warsaw in a container

# Base docker image
# fork from farribeiro/wscef-docker , mas rodando em CentOS - Os creditos da ideia sao dele.

FROM centos:7
LABEL maintainer "jsalatiel"


# Por algum motivo macabro, o warsar da CEF funciona no BB mas o contrario nao.
# CEF
ADD https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.rpm /src/warsaw.rpm
# BB
# ADD https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.rpm /src/warsaw.rpm



COPY startup.sh /home/ff/

RUN yum update -y && yum install -y --nogpgcheck  firefox xauth redhat-lsb-core make openssl sudo xauth \
        && groupadd -g 1000 -r ff \
        && useradd -u 1000 -r -g ff -G audio,video ff -d /home/ff \
        && chmod 744 /home/ff/startup.sh \
        && chown -R ff:ff /home/ff \
        && echo 'ff ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
        && echo 'Defaults !requiretty' >> /etc/sudoers && yum clean all

# Run firefox as non privileged user
USER ff

# Add volume for recipes PDFs
VOLUME "/home/ff/Downloads"

# Autorun chrome
CMD [ "/home/ff/startup.sh" ]

