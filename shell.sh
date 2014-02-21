#!/bin/bash

# launch all our services into the background
/usr/bin/supervisord &>/dev/null &

# start our shell
exec /bin/bash
