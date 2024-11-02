#!/bin/bash


inv_local_user(){
cat /etc/passwd  |cut -d: -f1 | while read ident ;do
    echo -n "$ident,$(hostname -s),$(hostname -s),Linux Server,"
    if [[ $(sudo -l -U $ident |grep 'ALL'|wc -l) -gt 0 ]]
        then
            echo -n "Admin,"
        else
            echo -n "User,"
    fi 
    case $(sudo passwd -S $ident | cut -d ' ' -f 2) in
        PS)
            echo -n "Active,"
            ;;
        LK)
            echo -n "Locked,"
            ;;
        *)
            echo -n "Undefined,"
            ;;
    esac
    echo -n "$(sudo passwd -S $ident | cut -d ' ' -f 3),"
    echo "$(date +"%Y-%m-%d")"
done
}

inv_local_user