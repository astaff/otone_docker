#
# Container for OT.one labware 
#
# Expects the following environment variables:
# CROSSBAR_HOST
# CROSSBAR_PORT
#
FROM common-build

WORKDIR /home
RUN wget https://github.com/OpenTrons/sandbox-labware/archive/master.zip -O temp.zip && unzip temp.zip && rm temp.zip
RUN wget https://github.com/OpenTrons/labware/archive/master.zip -O temp.zip && unzip temp.zip && rm temp.zip
RUN cd labware-master && cp -r labsuite ../sandbox-labware-master/
WORKDIR /home/sandbox-labware-master

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Make client read crossbar host/port from environment variables
COPY client.diff client.diff
RUN patch labware_client.py < client.diff
COPY driver.diff driver.diff
RUN patch labware_driver.py < driver.diff
# Fix broken import
COPY labware.diff labware.diff
RUN cd labsuite/engine && patch session.py < ../../labware.diff

ENTRYPOINT ["tar", "-cvz", "/usr/lib/python3.5/site-packages/", "/home/sandbox-labware-master"]

# Clean cache
# RUN rm -rf /var/cache/apk/*

#ENTRYPOINT ["python3", "labware_client.py"]
