#!/bin/bash
sudo ipfw flush
sudo ipfw add 100 fwd 127.0.0.1,2345 tcp from any to me 80
sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
