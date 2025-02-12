#!/bin/ash

apk add --upgrade curl make clang19 zlib-dev

get_p1xbraten_version() {
    echo $(basename "$(curl -s -o /dev/null -w '%{redirect_url}' https://github.com/sauerbraten/p1xbraten/releases/latest)")
}

fetch_source() {
    local v=$1
    wget -q -O p1xbraten.zip https://github.com/sauerbraten/p1xbraten/archive/refs/tags/${v}.zip
    unzip p1xbraten.zip \
        p1xbraten-${v}/src/enet/* p1xbraten-${v}/src/shared/* \
        p1xbraten-${v}/src/engine/* p1xbraten-${v}/src/fpsgame/* \
        p1xbraten-${v}/src/p1xbraten/* p1xbraten-${v}/src/Makefile
    rm -r -f src
    mv p1xbraten-${v}/src src
    rm -r -f p1xbraten.zip p1xbraten-${v}
}

compile() {
    local v=$1
    cd src
    sed -i "s/<git-dev>/${v}/" p1xbraten/version.cpp
    make server || exit
    strip sauer_server
    mv sauer_server ../p1xbraten_server
}

version=$(get_p1xbraten_version)
fetch_source $version
compile $version

rm -r -f src
