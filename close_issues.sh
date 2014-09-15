#!/bin/bash
set -o errexit
green='\e[0;32m'
red='\e[0;31m'
NC='\e[0m'

while getopts ":u:h" opt; do
  case $opt in
    u)
      USER=$OPTARG
      ;;
    h)
      echo "Usage: $0 -u <username> item1 [item2 [...]]"
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift "$((OPTIND-1))"
ITEMS=$*

read -s -p "Password for $USER: " PASS

for item in $ITEMS
do
  if ! curl -X PUT -H "Content-Type:application/json" -u "$USER":"$PASS" -d '{"issue": {"notes": "Manually closed as the nagios alert is cleared.", "status_id": 5}}' https://support.forgeservicelab.fi/redmine/issues/"$item".json; then
    echo -e "[${red}Error${NC}] Couldn't close issue #$item. All previous issues updated correctly" >&2
    exit 1
  fi
done

echo
echo -e "[${green}OK${NC}] All issues closed."
