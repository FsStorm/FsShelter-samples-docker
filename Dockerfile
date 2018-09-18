FROM fsharp:10.2.1-netcore
MAINTAINER Eugene Tolmachev 
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y software-properties-common \
        python-minimal wget git locales \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
RUN echo $LANG UTF-8 > /etc/locale.gen && /usr/sbin/locale-gen 

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN mkdir -p /usr/share/man/man1 
RUN apt-get update && apt-get install -y openjdk-8-jdk 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/ 

ENV STORM_RELEASE 1.2.2
RUN wget -nv -O /storm.tar.gz \
    http://www.apache.org/dist/storm/apache-storm-${STORM_RELEASE}/apache-storm-${STORM_RELEASE}.tar.gz 
RUN mkdir -p /opt/storm && \
    tar xzf /storm.tar.gz --strip=1 -C /opt/storm && \
    rm /storm.tar.gz

ENV STORM_HOME /opt/storm
RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm 

WORKDIR /opt
RUN git clone --depth 1 https://github.com/Prolucid/FsShelter.git

WORKDIR FsShelter
RUN ./build.sh build

ENTRYPOINT ["/bin/bash","-c","storm dev-zookeeper & storm nimbus & storm supervisor & storm ui"]
EXPOSE 8080
