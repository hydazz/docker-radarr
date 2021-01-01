## Alpine Edge fork of [linuxserver/docker-radarr](https://github.com/linuxserver/docker-radarr/)
[Radarr](https://radarr.video/) - A fork of Sonarr to work with movies à la Couchpotato.

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/radarr) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/radarr?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/auto_build-daily-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-radarr/actions?query=workflow%3A%22Cron+Update+CI%22)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6 overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![radarr](https://img.shields.io/badge/radarr-3.0.1.4345-blue?style=for-the-badge)

## Usage
```
docker run -d \
  --name=radarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e UMASK_SET=022 `#optional` \
  -e DEBUG=true/false `#optional` \
  -p 7878:7878 \
  -v <path to appdata>:/config \
  -v <path to movies>:/movies \
  -v <path to downloads>:/downloads \
  --restart unless-stopped \
  vcxpz/radarr
```
## Credits
* [spritsail/radarr](https://github.com/spritsail/radarr) for the `HEALTHCHECK` command
* [hotio](https://github.com/hotio) for the `redirect_cmd` function

## Todo
* Nothing, everything works 🙂
