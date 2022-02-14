#!/bin/bash

/usr/bin/ffmpeg \
  -f video4linux2 -framerate 25 -video_size 1280x720 -i /dev/video0 \
  -c:a libfdk_aac -b:a 128k -ar 16000 -ac 1 \
  -c:v libx264 -b:v 2500k \
  -f flv -g 25 -r 25 -s 1280x720 -preset ultrafast \
  rtmp://127.0.0.1:1935/encoder/cam1
