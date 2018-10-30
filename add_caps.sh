#!/bin/bash

user=$USER
sudo singularity capability add --user $user CAP_NET_RAW,CAP_NET_BIND_SERVICE,CAP_NET_BROADCAST
sudo singularity capability list --user $user
