#!/bin/bash

# docker run --rm \
#     -v /var/run/docker.sock:/var/run/docker.sock \
#     teamgosh/image-hash awnion/test_gosh_repo

# Error: {"killed":false,"code":1,"signal":null,"cmd":"docker exec teamgosh-docker-extension-desktop-extension-service /command/gosh-image-sha.sh sha256:a2c9241854f26c170a702284aadc31abae9896c591ed4ac4e05cda29964f81a3","stdout":"","stderr":"/command/gosh-image-sha.sh: 15: docker: not found\n"}
# docker exec teamgosh-docker-extension-desktop-extension-service /command/gosh-image-sha.sh sha256:a2c9241854f26c170a702284aadc31abae9896c591ed4ac4e05cda29964f81a3

rm -rf repo || true
GOSH_ADDRESS="gosh://0:9737a5933be0d3fcdf88eb5691a3b6629c56fc88f27bbbde2894d9d89a3a15e0/meow/docker"

echo repo_addr === "${GOSH_ADDRESS//gosh/gosh::vps23.ton.dev}"
gosh clone "${GOSH_ADDRESS//gosh/gosh::vps23.ton.dev}" repo
cd repo || exit 1

GOSH_COMMIT_HASH=$(git rev-parse HEAD)
echo repo_hash === "$GOSH_COMMIT_HASH"

docker build \
    --label GOSH_COMMIT_HASH="$GOSH_COMMIT_HASH" \
    --label GOSH_ADDRESS="$GOSH_ADDRESS" \
    -t test_gosh_repo \
    -t awnion/test_gosh_repo \
    .

cd ..

docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    teamgosh/image-hash test_gosh_repo
