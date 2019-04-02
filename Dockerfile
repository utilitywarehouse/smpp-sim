FROM adoptopenjdk/openjdk10:alpine-slim

ARG VERSION=0.11.0

ENV LANG=C.UTF-8 \
    JAVA_HOME=/opt/java/openjdk \
    PATH=${PATH}:/opt/java/openjdk/bin \
    LANG=C.UTF-8 

RUN apk add --no-cache ca-certificates bash curl

RUN sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/ $JAVA_HOME/conf/security/java.security

COPY SMPPSim /opt/smppsim

RUN chmod +x /opt/smppsim/startsmppsim.sh

RUN ["/bin/bash", "-c", "echo \"export LANG=C.UTF-8\" > /etc/profile.d/locale.sh"]

WORKDIR /opt/smppsim

EXPOSE 2775

CMD /opt/smppsim/startsmppsim.sh