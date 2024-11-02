#!/bin/bash

## inventory local user using lslogins
inv_local_user(){
lslogins -aupc | cut -d: -f2 | sed 1d | while read ident ;do
    echo -n "$ident,$(hostname -s),$(hostname -s),Linux Server,"
    if [[ $(sudo -l -U $ident |grep 'ALL'|wc -l) -gt 0 ]]
    then
        echo -n "Admin"
    else
        echo -n "Normal User"
    fi
    echo ",Active,$(date +"%Y/%m/%d")"
done
}

inv_local_user