#! /bin/bash

set -e

sudo -v

DIRNAME="$(dirname $(readlink -f $0))"

function create {
    DIR="$DIRNAME/$1"

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

for COPY_ENV in wordpress mariadb web
do
    FILE_ENV=$DIRNAME/.env_${COPY_ENV}
    if [ -f "$FILE_ENV" ];
    then
        echo "$FILE_ENV file exists."
    else
        echo "$FILE_ENV file does not exist. Create..."
        cp ${FILE_ENV}.dist $DIRNAME/.env_${COPY_ENV}
    fi
done
