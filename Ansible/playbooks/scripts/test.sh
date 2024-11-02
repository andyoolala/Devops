#!/bin/bash
check_cmd_present(){
if command -v $1 &> /dev/null
then
    exit 0
else
    exit 1
fi
}

check_cmd_present realm;echo $?