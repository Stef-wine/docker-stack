#! /bin/bash

set -e

sudo -v

function create {
    DIR="$(dirname $(readlink -f $0))/$1"

    if [ -d "$DIR" ];
    then
        echo "$DIR directory exists."
    else
        echo "$DIR directory does not exist. Create..."
        mkdir -p $DIR \
            && sudo chown "$2:$3" $DIR \
            && sudo chmod 770 $DIR
    fi
}

create bw-data $UID 101
create bw-data/www $UID 33
create db-data $UID $GID
