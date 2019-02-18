#!/bin/bash

# You must accept the Oracle Binary Code License
# http://www.oracle.com/technetwork/java/javase/terms/license/index.html
# usage: java-downloader.sh <jdk_version> <jdk_minor_version> <ext>
# jdk_version: 8(default) or 9
# jdk_minor_version: 201 or 202(default)
# ext: rpm or tar.gz

jdk_version=${1:-8}
jdk_minor_version=${2:-*}
ext=${3:-tar.gz}

readonly url="https://www.oracle.com"
readonly jdk_download_url1="$url/technetwork/java/javase/downloads/index.html"
readonly jdk_download_url2=$(
    curl -s $jdk_download_url1 | \
    egrep -o "\/technetwork\/java/\javase\/downloads\/jdk${jdk_version}-downloads-.+?\.html" | \
    head -1 | \
    cut -d '"' -f 1
)
[[ -z "$jdk_download_url2" ]] && echo "Could not get jdk download url - $jdk_download_url1" >> /dev/stderr

readonly jdk_download_url3="${url}${jdk_download_url2}"
readonly jdk_download_url4=$(
    curl -s $jdk_download_url3 | \
    egrep -o "https\:\/\/download.oracle\.com\/otn-pub\/java\/jdk\/[8-9](u[0-9]+|\+).*\/jdk-${jdk_version}u${jdk_minor_version}.*(-|_)linux-(x64|x64_bin).$ext"
)

# for dl_url in ${jdk_download_url4[@]}; do
#    wget --no-cookies \
#         --no-check-certificate \
#         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#         -N $dl_url
# done

echo  $jdk_download_url4 | awk '{print $1;}'