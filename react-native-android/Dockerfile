#based on https://raw.githubusercontent.com/react-native-community/docker-android/refs/heads/main/Dockerfile on fev/2025
#docker build -t alallk/react-native-android .
#docker push alallk/react-native-android:latest
FROM ubuntu:22.04

LABEL Description="This image provides a base Android development environment for React Native, and may be used to run tests."

ENV DEBIAN_FRONTEND=noninteractive

# set default build arguments
# https://developer.android.com/studio#command-tools
ARG SDK_VERSION=commandlinetools-linux-11076708_latest.zip
ARG ANDROID_BUILD_VERSION=36
ARG ANDROID_TOOLS_VERSION=36.0.0
ARG NDK_VERSION=27.1.12297006
ARG NODE_VERSION=22.14
ARG WATCHMAN_VERSION=4.9.0
ARG CMAKE_VERSION=3.30.5
ARG GRADLE_VERSION=8.14
ARG BUNDLETOOL_VERSION=1.18.0

# set default environment variables, please don't remove old env for compatibilty issue
ENV ADB_INSTALL_TIMEOUT=10
ENV GRADLE_HOME=/opt/gradle
ENV ANDROID_HOME=/opt/android
ENV BUNDLETOOL_HOME=/opt/bundletool
ENV ANDROID_SDK_ROOT=${ANDROID_HOME}
ENV ANDROID_NDK_HOME=${ANDROID_HOME}/ndk/$NDK_VERSION

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV CMAKE_BIN_PATH=${ANDROID_HOME}/cmake/$CMAKE_VERSION/bin

ENV PATH=${CMAKE_BIN_PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${GRADLE_HOME}/bin:${PATH}

# Install system dependencies
RUN apt update -qq && apt install -qq -y \
        apt-transport-https \
        curl \
        file \
        gcc \
        git \
        g++ \
        gnupg2 \
        libc++1-11 \
        libgl1 \
        libtcmalloc-minimal4 \
        make \
        openjdk-17-jdk-headless \
        openssh-client \
        patch \
        python3 \
        python3-distutils \
        rsync \
        ruby \
        ruby-dev \
        tzdata \
        unzip \
        sudo \
        ninja-build \
        zip \
        ccache \
        # Dev libraries requested by Hermes
        libicu-dev \
        # Dev dependencies required by linters
        jq \
        shellcheck \
    && gem install bundler \
    && rm -rf /var/lib/apt/lists/*;

# install nodejs using n
RUN curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n \
    && bash n $NODE_VERSION \
    && rm n \
    && npm install -g n \
    && npm install -g yarn

# Full reference at https://dl.google.com/android/repository/repository2-1.xml
# download and unpack android
RUN curl -sS https://dl.google.com/android/repository/${SDK_VERSION} -o /tmp/sdk.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && unzip -q -d ${ANDROID_HOME}/cmdline-tools /tmp/sdk.zip \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm /tmp/sdk.zip \
    && yes | sdkmanager --licenses \
    && yes | sdkmanager "platform-tools" \
        "platforms;android-$ANDROID_BUILD_VERSION" \
        "build-tools;$ANDROID_TOOLS_VERSION" \
        "cmake;$CMAKE_VERSION" \
        "ndk;$NDK_VERSION" \
    && rm -rf ${ANDROID_HOME}/.android \
    && chmod 777 -R /opt/android

# Disable git safe directory check as this is causing GHA to fail on GH Runners
RUN git config --global --add safe.directory '*'

# download and unpack gradlew
RUN curl -k -L -v -X GET https\://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o /tmp/gradle.zip \
    && mkdir -p ${GRADLE_HOME}  \
    && unzip -q -d /tmp /tmp/gradle.zip \
    &&  mv /tmp/gradle-${GRADLE_VERSION}/* ${GRADLE_HOME} \
    &&  rm -rf /tmp/* \
    && chmod 777 -R ${GRADLE_HOME}

# download bundletool and configure to run on alias
RUN curl -k -L -v -X GET https\://github.com/google/bundletool/releases/download/${BUNDLETOOL_VERSION}/bundletool-all-${BUNDLETOOL_VERSION}.jar -o /tmp/bundletool.jar \
    && mkdir -p ${BUNDLETOOL_HOME}  \
    && mv /tmp/bundletool.jar ${BUNDLETOOL_HOME}/bundletool.jar \
    &&  rm -rf /tmp/* \
    && alias bundletool='java -jar ${BUNDLETOOL_HOME}/bundletool.jar' \
    && echo 'alias bundletool="java -jar ${BUNDLETOOL_HOME}/bundletool.jar"' >> ~/.bashrc

#Clear image
RUN apt clean autoclean \
    && apt autoremove -y --purge \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/
