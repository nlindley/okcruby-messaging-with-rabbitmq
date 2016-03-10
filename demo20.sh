#!/bin/sh
# https://www.rabbitmq.com/community-plugins.html

RABBITMQ_SERVER_PATH=$(which rabbitmq-server)

if [ -L $RABBITMQ_SERVER_PATH ]
then
  RABBITMQ_SERVER_PATH="$(dirname $RABBITMQ_SERVER_PATH)/$(readlink $RABBITMQ_SERVER_PATH)"
fi

PLUGINS_PATH="$(dirname $RABBITMQ_SERVER_PATH)/../plugins"
cd $PLUGINS_PATH
pwd

if [ ! -f rabbitmq_delayed_message_exchange-0.0.1.ez ]
then
  echo 'Downloading plugin'
  curl -O https://www.rabbitmq.com/community-plugins/v3.6.x/rabbitmq_delayed_message_exchange-0.0.1.ez
else
  echo 'Plugin exists'
fi

rabbitmq-plugins enable rabbitmq_delayed_message_exchange
