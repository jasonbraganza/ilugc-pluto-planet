#!/bin/bash
eval "$(rbenv init -)"
pluto build /root/mount/planet.ini -o /root/mount/output --template news
mv /root/mount/output/planet.news.html /root/mount/output/index.html
