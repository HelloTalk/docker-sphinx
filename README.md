# docker-sphinx
sphinx 2.2.11 with glibc 2.27 docker image

## run docker
```bash
docker run --name sphinxsearch -d -p 9306:9306 -p 9312:9312 \
-v /usr/local/sphinx/docker/sphinx.conf:/usr/local/sphinx/etc/sphinx.conf \
-v /usr/local/sphinx/docker/data:/usr/local/sphinx/var/data \
-v /usr/local/sphinx/docker/log:/usr/local/sphinx/var/log hellotalk/sphinxsearch:latest
```

## index
```bash
/usr/local/sphinx/bin/indexer --rotate location
```
