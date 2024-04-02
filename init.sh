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

        mkdir -p $DIR

        if  [[ -n $2 ]];
        then
            sudo chown "$2" $DIR \
            && sudo chmod 770 $DIR
        fi
    fi
}

create bw-data "101:101"
create db-data
create odoo/data "101:101"
create odoo/addons "101:101"

for COPY_ENV in odoo postgres web
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
