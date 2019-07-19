#!/usr/bin/env bash
 
# Simple move this file into your Rails `script` folder. Also make sure you `chmod +x puma.sh`.
# Please modify the CONSTANT variables to fit your configurations.
 
# The script will start with config set by $PUMA_CONFIG_FILE by default

PUMA_CONFIG_FILE=config/puma.rb
PUMA_PID_FILE=/apps/orth/project/shared/tmp/orth.puma.pid
PUMA_SOCKET=/apps/orth/project/shared/tmp/sockets/puma.sock
 
# check if puma process is running
puma_is_running() {
  if [ -S $PUMA_SOCKET ] ; then
    if [ -e $PUMA_PID_FILE ] ; then
      if ps -p $(cat $PUMA_PID_FILE) > /dev/null ; then
        return 0
      else
        echo "No puma process found"
      fi
    else
      echo "No puma pid file found"
    fi
  else
    echo "No puma socket found"
  fi
 
  return 1
}
 
case "$1" in
  start)
    echo "Starting puma..."
    rm -f $PUMA_SOCKET
    bundle exec puma --daemon --bind unix://$PUMA_SOCKET --pidfile $PUMA_PID_FILE --config $PUMA_CONFIG_FILE
 
    echo "done"
    ;;
 
  stop)
    echo "Stopping puma..."
      kill -s SIGTERM `cat $PUMA_PID_FILE`
      rm -f $PUMA_PID_FILE
      rm -f $PUMA_SOCKET
 
    echo "done"
    ;;
 
  restart)
    if puma_is_running ; then
      echo "Hot-restarting puma..."
      kill -s SIGUSR2 `cat $PUMA_PID_FILE`
 
      echo "Doublechecking the process restart..."
      sleep 15
      if puma_is_running ; then
        echo "done"
        exit 0
      else
        echo "Puma restart failed :/"
      fi
    fi
 
    echo "Trying cold reboot"
    script/puma.sh start
    ;;
 
  *)
    echo "Usage: script/puma.sh {start|stop|restart}" >&2
    ;;
esac

