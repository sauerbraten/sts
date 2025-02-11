#!/bin/ash

apk add --upgrade make clang19 zlib-dev curl

p1xbraten_version=$(basename "$(curl -s -o /dev/null -w '%{redirect_url}' https://github.com/sauerbraten/p1xbraten/releases/latest)")

wget -q -O p1xbraten.zip https://github.com/sauerbraten/p1xbraten/archive/refs/tags/${p1xbraten_version}.zip
unzip p1xbraten.zip p1xbraten-${p1xbraten_version}/src/* \
    -x "p1xbraten-${p1xbraten_version}/src/EOS/*" "p1xbraten-${p1xbraten_version}/src/anticheat/*" "p1xbraten-${p1xbraten_version}/src/macos/*" "p1xbraten-${p1xbraten_version}/src/windows/*"
mkdir src
mv p1xbraten-${p1xbraten_version}/src/* ./src
rm -r p1xbraten.zip p1xbraten-${p1xbraten_version}

cd src
sed -i "s/<git-dev>/${p1xbraten_version}/" p1xbraten/version.cpp
make server
strip sauer_server
mv sauer_server ../p1xbraten_server

cd ..
rm -r src
