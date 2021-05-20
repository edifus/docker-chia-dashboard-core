FROM ghcr.io/linuxserver/baseimage-alpine:3.12

LABEL maintainer="edifus"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	g++ \
	make \
	nodejs-npm && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	git \
	nodejs && \
 npm config set unsafe-perm true && \
 echo "**** install chia-dashboard-core ****" && \
 git -C /app clone https://github.com/felixbrucker/chia-dashboard-core.git && \
 echo "**** install node modules ****" && \
 npm install --prefix /app/chia-dashboard-core && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root \
	/tmp/* && \
 mkdir -p \
	/root

# add local files
COPY root/ /

# ports
EXPOSE 5000