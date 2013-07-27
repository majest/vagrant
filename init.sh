#!/bin/sh

if ! dpkg -s make | grep "Status: install ok installed"; then
sudo apt-get install make     
fi

