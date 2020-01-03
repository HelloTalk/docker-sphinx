#!/usr/bin/bash
#set -x

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd ${DIR}
docker-compose restart sphinx-index
sleep 5
if docker-compose logs -f --tail 3 sphinx-index | grep 'successfully sent SIGHUP to searchd'
then
  echo "Index successfully"
  docker-compose exec sphinx-searchd killall -HUP searchd
  echo "Restart searchd successfully"
fi
