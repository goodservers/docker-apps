FROM mhart/alpine-node:10

# create workdir
RUN mkdir -p /app

# set workdir
WORKDIR /app

# port for APP
EXPOSE 3000

# cache web and common dir dependencies
COPY yarn.lock package.json ./
RUN yarn install

RUN chmod 777 /app

COPY ./.deploy/harden.sh /usr/local/bin/harden.sh
RUN chmod 777 /usr/local/bin/harden.sh
RUN /usr/local/bin/harden.sh

USER user

# Copy the code
COPY . .

RUN yarn build

ENTRYPOINT yarn start