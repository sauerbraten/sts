#!/bin/ash

prepare_server_dir()
{
    local server_num=$1
    local dirname=${SERVER_REGION}${server_num}
    cp -r template ${dirname}
    SERVER_NUM=${server_num} envsubst <${dirname}/server-init.cfg.tpl >${dirname}/server-init.cfg
    echo ${dirname}
}

stream_logs()
{
    local dirname=$1
    echo "streaming logs from ${dirname}"
    tail -f "${dirname}/logs.txt" | sed "s/^/[${dirname}] /" &
}

for i in $(seq 1 ${NUM_SERVERS}); do
    dirname=$(prepare_server_dir ${i})
    ./server -q${dirname} -glogs.txt &
    stream_logs ${dirname}
done

wait
