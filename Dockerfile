FROM clojure:tools-deps

RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 14.18.1
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN  npx tailwindcss -i global.css -o resources/public/assets/css/output.css --minify

RUN npm i

RUN npx shadow-cljs release app

RUN clj -T:build uber

CMD [ "java", "-jar", "target/app-standalone.jar" ]

