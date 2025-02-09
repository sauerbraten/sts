FROM docker.io/library/alpine:latest as builder

RUN apk add --upgrade \
    make \
    clang19 \
    zlib-dev

WORKDIR /src

RUN wget -q -O p1xbraten.zip https://github.com/sauerbraten/p1xbraten/archive/refs/tags/8.4.3.zip
RUN unzip p1xbraten.zip p1xbraten-8.4.3/src/* -x 'p1xbraten-8.4.3/src/EOS/*' 'p1xbraten-8.4.3/src/anticheat/*' 'p1xbraten-8.4.3/src/macos/*' 'p1xbraten-8.4.3/src/windows/*' && \
    mv p1xbraten-8.4.3/src/* . && \
    rm p1xbraten.zip

RUN make server && \
    strip sauer_server


FROM docker.io/library/alpine:latest

RUN apk add --upgrade libstdc++ envsubst

WORKDIR /app

COPY --chmod=755 ./entrypoint.sh entrypoint.sh

# remove the next line when you don't use p1xbraten sources or `/checkmaps` will fail
RUN wget -q -O - https://static.p1x.pw/slim_ogzs.tar.gz | tar -xzof -

COPY --from=builder /src/sauer_server server

# make sure you have a config and auth keys!
COPY ./template template

# remove -i part when not running on fly.io
CMD [ "./entrypoint.sh" ]