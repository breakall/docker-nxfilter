FROM centos:latest
MAINTAINER Michael Mast
#Keep base up to date
RUN yum -y upgrade
#Import the key and repo for the offical NXFilter supported repo
RUN rpm --import http://www.deepwoods.net/repo/deepwoods/RPM-GPG-KEY-deepwoods && rpm -Uhv http://www.deepwoods.net/repo/deepwoods/deepwoods-release-6-2.noarch.rpm
#Install nxfilter and sslspit (split is not implented here)
RUN yum -y install nxfilter*
#Setup java to run as non-root
RUN groupadd -g 54628 nxfilter && useradd -u 54682 -g nxfilter nxfilter && chown -R nxfilter:nxfilter /nxfilter
RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-2.el7_6.x86_64/jre/bin/java
RUN find / -name 'libjli.so' -exec /usr/bin/ln -s {} /usr/lib/ \; && ldconfig
#Run this sucker!
CMD su nxfilter /nxfilter/bin/startup.sh
