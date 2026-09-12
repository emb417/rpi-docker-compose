#!/bin/sh
curl -s -o /dev/null -w "%{http_code}\n" --max-time 10 --unix-socket /var/run/docker.sock -X POST "http://localhost/containers/rpi-docker-compose-nginx-1/kill?signal=HUP"
