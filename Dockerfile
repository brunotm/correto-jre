FROM ubuntu:18.04
LABEL maintainer="brunotm@gmail.com"

# Amazon correto version and default environment variables
ENV JDK_RELEASE="amazon-corretto-8.202.08.2-linux-x64"
ENV JDK_URL="https://d2znqt9b1bc64u.cloudfront.net/${JDK_RELEASE}.tar.gz"
ENV JAVA_HOME="/opt/${JDK_RELEASE}"
ENV JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport"
ENV PATH="${PATH}:${JAVA_HOME}/bin"

RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends curl ca-certificates \
	&& apt-get --purge autoremove -y \
	&& apt-get clean \
	&& rm -rf /root/.cache/* \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -XGET "${JDK_URL}" -o /tmp/"${JDK_RELEASE}.tar.gz" \
	&& tar xfz /tmp/"${JDK_RELEASE}.tar.gz" -C /tmp \
	&& mv /tmp/*/jre /opt/${JDK_RELEASE} \
	&& rm -rf /tmp/*

CMD ["bash"]