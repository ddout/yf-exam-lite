#!/bin/sh

set -eo pipefail

set +e

# Script trace mode
if [ "${DEBUG_MODE}" == "true" ]; then
    set -o xtrace
fi

JAVA_OPTS=${JAVA_OPTS:-"-Xms512m -Xmx1024m"}

APPS_HOME=/home/zhishen/apps/exam
UPLAOD_HOME=$APPS_HOME/uploads
CONF_HOME=$APPS_HOME/config
APPS_CONF=$CONF_HOME/application.properties

LOGGING_LEVEL=${LOGGING_LEVEL:-"info"}


if [ "${SERVER_PORT}" != "" ]; then
    echo "server.port=$SERVER_PORT" >> $APPS_CONF
fi

if [ "${DATASOURCE_URL}" != "" ]; then
    echo "spring.datasource.url=$DATASOURCE_URL" >> $APPS_CONF
fi

if [ "${DATASOURCE_USERNAME}" != "" ]; then
    echo "spring.datasource.username=$DATASOURCE_USERNAME" >> $APPS_CONF
fi

if [ "${DATASOURCE_PASSWORD}" != "" ]; then
    echo "spring.datasource.password=$DATASOURCE_PASSWORD" >> $APPS_CONF
fi


if [ "${REDIS_HOST}" != "" ]; then
    REDIS_HOST=${REDIS_HOST:-"127.0.0.1"}
    echo "spring.redis.host=$REDIS_HOST" >> $APPS_CONF
fi

if [ "${REDIS_PORT}" != "" ]; then
    echo "spring.redis.port=$REDIS_PORT" >> $APPS_CONF
fi

if [ "${REDIS_PASSWORD}" != "" ]; then
    echo "spring.redis.password=$REDIS_PASSWORD" >> $APPS_CONF
fi



echo "logging.level.root=$LOGGING_LEVEL" >> $APPS_CONF

mkdir -p $UPLAOD_HOME/files
mkdir -p $UPLAOD_HOME/webapp
#mkdir -p $UPLAOD_HOME/pictures

#################################################
echo "########################################################"
echo "正在启动接口服务.."
java $JAVA_OPTS -Dfile.encoding=UTF-8 -Dspring.profiles.active=pro -Djava.security.egd=file:/dev/./urandom -jar app.jar

#################################################
