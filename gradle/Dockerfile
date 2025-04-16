#docker build -t alallk/gradlenpm .
FROM gradle:7.6.4-jdk-jammy

ARG COMPOSE_VERSION=2.35.0

# Add Docker's official GPG key:
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

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
    xauth \ 
    ufw \
    ca-certificates \
    docker-ce-cli

RUN npm install -g n && n stable && n 18.17.1

RUN DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
RUN mkdir -p $DOCKER_CONFIG/cli-plugins
RUN curl -SL https://github.com/docker/compose/releases/download/v${COMPOSE_VERSION}/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose

RUN rm -rf /var/lib/apt/lists/*