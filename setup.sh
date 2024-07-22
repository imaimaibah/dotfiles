#!/bin/bash

BASEPATH=${0%%$(basename $0)}
if [[ "x${BASEPATH}" == x"" ]];then
  BASEPATH=./
fi

for file in $(ls ${BASEPATH}*_custom);do
  dotfile=${file##*/}
  ln -s $(pwd)/${dotfile} ~/.${dotfile}
done


