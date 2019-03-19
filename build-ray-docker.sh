#!/bin/bash
set -x

while [[ $# -gt 0 ]]
do
key="$1"
case ${key} in
    --skip-deploy)
    SKIP_DEPLOY=YES
    ;;
    --output-sha)
    # output the SHA sum of the last built file (either ray-project/deploy
    # or ray-project/examples, suppressing all other output. This is useful
    # for scripting tests, especially when builds of different versions
    # are running on the same machine. It also can facilitate cleanup.
    OUTPUT_SHA=YES
    ;;
    *)
    echo "Usage: build-docker.sh [ --skip-worker ] [ --sha-sums ]"
    exit 1
esac
shift
done

#if [[ ${OUTPUT_SHA} ]]; then
#    IMAGE_SHA=$(docker build --no-cache -q -t registry.leapmind.xyz/huang/ray-base docker/ray-base)
#else
#    docker build --no-cache -t registry.leapmind.xyz/huang/ray-base docker/ray-base
#fi


if [[ ! ${SKIP_DEPLOY} ]]; then
    if [[ ${OUTPUT_SHA} ]]; then
        IMAGE_SHA=$(docker build --no-cache -q -t registry.leapmind.xyz/huang/ray-deploy docker/ray-deploy)
    else
        docker build --no-cache -t registry.leapmind.xyz/huang/ray-deploy docker/ray-deploy
    fi
fi


if [[ ${OUTPUT_SHA} ]]; then
    echo ${IMAGE_SHA} | sed 's/sha256://'
fi