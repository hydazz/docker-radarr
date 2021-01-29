#!/bin/bash

sed -i -E \
	-e "s/radarr-.*?-blue/radarr-${APP_VERSION}-blue/g" \
	README.md
