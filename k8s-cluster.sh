#!/bin/zsh

OS=$(uname)
ARCH=$(uname -m)

if [[ "$OS" == "Darwin" ]];then
  colima start --cpu 4 --memory 8
fi
kind create cluster
docker update --restart=no kind-control-plane 
