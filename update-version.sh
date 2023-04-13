#!/bin/bash

OLD_VERSION=`sed -n 's|[$]ffmpeg = "ffmpeg-\(.*\)"|\1|p' install.ps1`
NEW_VERSION=`curl https://ffmpeg.zeranoe.com/builds/ | grep -Po 'value="\K[0-9]+-[a-z0-9]+' | head -n 1`

./set-version $OLD_VERSION $NEW_VERSION
