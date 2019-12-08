FROM ubuntu:18.04
LABEL maintainer="brunotm@gmail.com"

# Amazon correto version and default environment variables
ENV JDK_RELEASE="8.232.09.1"
ENV JDK_URL="https://d3pxv6yz143wms.cloudfront.net/${JDK_RELEASE}/amazon-corretto-${JDK_RELEASE}-linux-x64.tar.gz"
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