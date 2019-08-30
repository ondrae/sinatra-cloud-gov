set -e

API="https://api.fr.cloud.gov" 
ORG="sandbox-gsa"
APP_NAME="andrew.hyder"

SPACE=$1

if [ $# -ne 1 ]; then
  echo "Usage: deploy <space>"
  exit
fi

if [ $SPACE = 'production' ]; then
  NAME=APP_NAME
  MANIFEST="manifest.yml"
elif [ $SPACE = 'staging' ]; then
  NAME="$APP_NAME-staging"
  MANIFEST="manifest-staging.yml"
else
  echo "Unknown space: $SPACE"
  exit
fi

cf login -a $API -u $CF_USERNAME -p $CF_PASSWORD -o $ORG -s $SPACE
cf zero-downtime-push $NAME -f $MANIFEST