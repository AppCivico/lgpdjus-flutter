#!/bin/bash

set -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PROJECT_DIR=$(dirname $SCRIPTPATH)
RUN_LANE=firebase_distribute

# extract arguments
for i in "$@"; do
  case $i in
    --release)
      RUN_LANE=release_distribute
      shift
      ;;
    -*|--*)
      echo "Unknown option '$i'"
      exit 1
      ;;
    *)
      ;;
  esac
done

for platform in ios android; do
    cd $PROJECT_DIR/$platform \
        && bundle install \
        && bundle exec fastlane $RUN_LANE --verbose
done
