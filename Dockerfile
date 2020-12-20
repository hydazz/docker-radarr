FROM vcxpz/baseimage-alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Fork of Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Alex Hyde"

# environment settings
ARG RADARR_RELEASE
ARG RADARR_BRANCH
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
 	curl \
 	icu-libs \
 	libintl \
 	libmediainfo \
 	sqlite-libs && \
 echo "**** install radarr ****" && \
 mkdir -p /app/radarr/bin && \
 curl -o \
 /tmp/radarr.tar.gz -L \
	"https://radarr.servarr.com/v1/update/${RADARR_BRANCH}/updatefile?version=${RADARR_RELEASE}&os=linuxmusl&runtime=netcore&arch=x64" && \
 tar xzf \
 /tmp/radarr.tar.gz -C \
	/app/radarr/bin --strip-components=1 && \
 printf "UpdateMethod=docker\nBranch=${RADARR_BRANCH}\n" > /app/radarr/package_info && \
 echo "**** cleanup ****" && \
 rm -rf \
	/app/radarr/bin/Radarr.Update \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 7878
VOLUME /config
