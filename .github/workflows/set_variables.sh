#!/bin/bash





#set -eu
set -x

if test "centos6" = ""; then
    echo "ERROR: OS env is empty"
    exit 1
fi

case "${GITHUB_EVENT_NAME}" in
    repository_dispatch)
        BRANCH=${PAYLOAD_BRANCH};;
    push)
        case "${GITHUB_REF}" in
            refs/heads/*)
                BRANCH=${GITHUB_REF#refs/heads/};;
            *)
                BRANCH=null;
        esac;;
esac
if [ -z ${BRANCH} ]; then
  BRANCH=null
fi
TAG_LATEST=""


TAG_BRANCH="metwork/mfxxx-centos6-testimage:${BRANCH}"
if test "${BRANCH}" = "master"; then
    TAG_LATEST="metwork/mfxxx-centos6-testimage:latest"
fi 

echo "::set-output name=branch::${BRANCH}"
echo "::set-output name=tag_branch::${TAG_BRANCH}"
echo "::set-output name=tag_latest::${TAG_LATEST}"
