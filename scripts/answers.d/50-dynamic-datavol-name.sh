#!/bin/sh

# PR DEPLOYMENT
if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo "ES_DATA_VOL=esdata-pr-${TRAVIS_PULL_REQUEST}" >> answers.txt
fi
