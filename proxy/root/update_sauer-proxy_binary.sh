#!/bin/ash

apk add --upgrade build-base cargo clang19-dev cmake

fetch_source() {
    rm -r -f sauer-proxy-master
    wget -q -O sauer-proxy-master.zip https://github.com/sauerbraten/sauer-proxy/archive/refs/heads/master.zip
    unzip sauer-proxy-master.zip
    rm sauer-proxy-master.zip
}

compile() {
    cd sauer-proxy-master
    cargo build --release
    strip ./target/release/sauer-proxy
    mv ./target/release/sauer-proxy ../sauer-proxy
    cd ..
}

fetch_source
compile

rm -r -f sauer-proxy-master
