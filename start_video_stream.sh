#!/bin/bash
mjpg_streamer -i "/usr/local/lib/mjpg-streamer/input_uvc.so -d /dev/video0" -o "/usr/local/lib/mjpg-streamer/output_http.so -p 8080"
