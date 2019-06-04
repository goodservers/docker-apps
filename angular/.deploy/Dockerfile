FROM mhart/alpine-node:10 AS builder
# create workdir
RUN mkdir -p /app

# set workdir
WORKDIR /app

# cache web and common dir dependencies
COPY package-lock.json package.json ./
RUN npm i

RUN chmod 777 /app

# Copy the code
COPY . .

RUN npm run-script build
# COPY dist .

FROM nginx:1.15-alpine

EXPOSE 80

COPY --from=builder /app/.deploy/default.conf /etc/nginx/conf.d

# Copy the code
COPY --from=builder /app/dist/{{PROJECT_NAME}} /var/www/html
