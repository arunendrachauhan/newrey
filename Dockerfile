FROM ubuntu:16.04

MAINTAINER arun
ADD provision.sh /opt/run.sh
RUN chmod +x /opt/run.sh
CMD ["./run.sh"]
