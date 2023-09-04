#!/bin/sh

ufw limit ssh
ufw allow 51280/udp
ufw --force enable
