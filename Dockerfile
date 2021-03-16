FROM node:12
LABEL maintainer "auto-build.com"

# Create app directory
WORKDIR /sources/project-cli/


# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json /sources/project-cli/


RUN npm install -g pm2 \
    && npm install
# If you are building your code for production
# RUN npm ci --only=production


# Bundle app source
COPY . /sources/project-cli/


EXPOSE 3000

CMD [ "pm2", "start", "app.js", "--no-daemon" ]