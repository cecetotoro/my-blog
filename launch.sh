#!/bin/bash
set -e
LOGFILE=/var/log/gunicorn/my-blog.log
LOGDIR=$(dirname $LOGFILE)
LOGLEVEL=debug   # info ou warning une fois l'installation OK
NUM_WORKERS=3    # Règle : (2 x $num_cores) + 1

# user/group to run as
USER=pi
GROUP=pi

cd /home/pi/my-blog
# source ../bin/activate  # Cette ligne ne sert que si vous utilisez virtualenv
test -d $LOGDIR || mkdir -p $LOGDIR
exec gunicorn_django -w $NUM_WORKERS \
  --user=$USER --group=$GROUP --log-level=$LOGLEVEL \
  --log-file=$LOGFILE 2>>$LOGFILE -b 127.0.0.1:8000
