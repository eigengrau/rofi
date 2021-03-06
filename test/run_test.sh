#!/usr/bin/env bash

XPID=
function create_fake_x ( )
{
    export DISPLAY=":$1"
    echo "Starting fake X: ${DISPLAY}"
    Xvfb ${DISPLAY} &
    XPID=$!
    sleep 1
}

function destroy_fake_x ( )
{
    if [ -n "${XPID}" ]
    then
        echo "Stopping fake X: ${XPID}"
        kill ${XPID}
        wait ${XPID}
    fi
}

if [ -n "$3"  ]
then
    export PATH=$3:$PATH
fi

create_fake_x "$1"
if [ -n "$4" ]
then
    xrdb -load "$4"
fi
echo "$DISPLAY"
$2
RES=$?

destroy_fake_x

exit ${RES}
