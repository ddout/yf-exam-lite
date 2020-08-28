FROM docker.aiaudit.com.cn/jdk/openjdk:8-jdk-alpine
LABEL MAINTAINER=zhouchun

EXPOSE 8101

ENV APP_HOME /home/zhishen/apps/exam

RUN mkdir -p $APP_HOME/uploads
RUN mkdir -p $APP_HOME/config

VOLUME /tmp
VOLUME $APP_HOME/config
VOLUME $APP_HOME/uploads

COPY target/exam-api.jar $APP_HOME/app.jar
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod 755 -c /usr/local/bin/docker-entrypoint.sh

WORKDIR $APP_HOME

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]


# docker build -t docker.aiaudit.com.cn/exam/exam-api:v1.0.0.002 .
# docker push docker.aiaudit.com.cn/exam/exam-api:v1.0.0.002