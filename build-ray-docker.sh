#!/bin/bash
set -x

while [[ $# -gt 0 ]]
do
key="$1"
case ${key} in
    --no-cache)
    NO_CACHE="--no-cache"
    ;;
    --skip-worker)
    SKIP_WORKER=YES
    ;;
    --output-sha)
    # output the SHA sum of the last built file (either ray-project/deploy
    # or ray-project/examples, suppressing all other output. This is useful
    # for scripting tests, especially when builds of different versions
    # are running on the same machine. It also can facilitate cleanup.
    OUTPUT_SHA=YES
    ;;
    *)
    echo "Usage: build-docker.sh [ --no-cache ] [ --skip-worker ] [ --sha-sums ]"
    exit 1
esac
shift
done

# Build the current Ray source
git rev-parse HEAD > ./docker/ray-head/git-rev
git archive -o ./docker/ray-head/ray.tar $(git rev-parse HEAD)
if [[ ${OUTPUT_SHA} ]]; then
    IMAGE_SHA=$(docker build --no-cache -q -t registry.leapmind.xyz/huang/ray-head docker/ray-head)
else
    docker build --no-cache -t registry.leapmind.xyz/huang/ray-head docker/ray-head
fi
rm ./docker/ray-head/ray.tar ./docker/ray-head/git-rev


if [[ ! ${SKIP_WORKER} ]]; then
    if [[ ${OUTPUT_SHA} ]]; then
        IMAGE_SHA=$(docker build ${NO_CACHE} -q -t registry.leapmind.xyz/huang/ray-worker docker/ray-worker)
    else
        docker build --no-cache -t registry.leapmind.xyz/huang/ray-worker docker/ray-worker
    fi
fi


if [[ ${OUTPUT_SHA} ]]; then
    echo ${IMAGE_SHA} | sed 's/sha256://'
fi