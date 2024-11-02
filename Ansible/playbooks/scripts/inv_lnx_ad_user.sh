#!/bin/bash

## inventory AD User
inv_ad_user(){
sudo cat /etc/sssd/sssd.conf |grep simple_allow_users |cut -d= -f2 |tr , "\n" | while read ident ;do
    echo -n "${ident}@$1,$(hostname -s),$(hostname -s),Linux Server,"
    if [[ $(sudo -l -U ${ident}@$1 |grep 'ALL'|wc -l) -gt 0 ]]
    then
        echo -n "Admin"
    else
        echo -n "Normal User"
    fi
    echo ",Active,$(date +"%Y/%m/%d")"
done
}

inv_ad_user $(realm list | grep domain-name | cut -d: -f2)
