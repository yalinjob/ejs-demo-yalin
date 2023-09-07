FROM node:18
ARG JF_TOKEN

# Create app directory
WORKDIR /usr/src/app
COPY package*.json ./
RUN apt-get update && \
    apt-get install -y curl make && \
    apt-get clean
RUN curl -fL https://install-cli.jfrog.io | sh

# added to ease demo for remote shell
RUN apt-get install -y ncat
# If you are building your code for production
RUN jf c import ${JF_TOKEN}
RUN jf npmc --repo-resolve=dro-npm-unsecure-remote
RUN jf npm ci --only=production
EXPOSE 3000

COPY server.js ./
COPY public public/
COPY views views/
COPY fake-creds.txt /usr/src/
CMD [ "node", "server.js" ]