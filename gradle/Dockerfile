FROM gradle:7.6.4-jdk-jammy

RUN apt-get update && apt-get install -y --no-install-recommends gnupg \
    jq \
    zip \
    npm \
    xvfb \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libxtst6 \
    xauth
RUN apt-get install -y ufw

RUN rm -rf /var/lib/apt/lists/*

RUN npm install -g n && n stable
RUN n 18.17.1
