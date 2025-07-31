FROM node:16.19.0
ARG JF_TOKEN

# Create app directory
WORKDIR /usr/src/app
COPY package.json ./

# Fix repository issues by switching to Debian archive for buster
RUN sed -i 's/http:\/\/deb.debian.org\/debian/http:\/\/archive.debian.org\/debian/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y curl make ncat && \
    apt-get clean

# If you are building your code for production
RUN npm i --omit dev
EXPOSE 3000

COPY server.js ./
COPY public public/
COPY views views/
COPY fake-creds.txt /usr/src/
CMD [ "node", "server.js" ]

