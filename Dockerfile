FROM node

MAINTAINER Dev@Nute

ADD . /home/nutefier

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/home/nutifier/"]

CMD ["node app.js"]
