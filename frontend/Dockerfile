#
# Container for OT.one frontend
#
# Notes:
# - The patch changes the name of the crossbar websocket connection in 
#   communication.js to otone.local to make testing easier so one could
#   set a name of the ot.one host in /etc/hosts
#

FROM common-build

WORKDIR /home
RUN wget https://github.com/OpenTrons/sandbox-frontend/archive/master.zip -O temp.zip && unzip temp.zip && rm temp.zip
WORKDIR /home/sandbox-frontend-master
RUN pip3 install -r requirements.txt

COPY patch.diff patch.diff
RUN cd static/js && patch communication.js < ../../patch.diff

RUN rm -rf /var/cache/apk/*

ENTRYPOINT ["tar", "-cvz", "/usr/lib/python3.5/site-packages/", "/home/sandbox-frontend-master"]
# EXPOSE 5000
# ENTRYPOINT ["foreman", "start"]