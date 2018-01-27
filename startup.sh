#!/bin/bash

export LANG="en_US.UTF-8"

if [ -n "${XAUTHORITY}" ] && [ -n "${HOST_HOSTNAME}" ]
then
  if [ "${HOSTNAME}" != "${HOST_HOSTNAME}" ]
  then
    [ -f ${XAUTHORITY} ] || touch ${XAUTHORITY}
    xauth add ${HOSTNAME}/unix${DISPLAY} . \
    $(xauth -f /tmp/.docker.xauth list ${HOST_HOSTNAME}/unix${DISPLAY} | awk '{ print $NF }')
  else
    cp /tmp/.docker.xauth ${XAUTHORITY}
  fi
fi
if [ ! -d ~/.mozilla ] ; then
	firefox --no-remote -CreateProfile default
	sudo rpm -i --nodeps --force /src/warsaw_setup64.rpm &>/dev/null
else
	sudo /etc/init.d/warsaw start
fi
/usr/local/bin/warsaw/core && firefox --no-remote -private-window https://seg.bb.com.br
