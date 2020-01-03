# docker-sphinx
sphinx 2.2.11 with glibc 2.27 docker image

## prepare
```bash
git clone https://github.com/HelloTalk/docker-sphinx.git
```

## container orchestration
```bash
cd docker-sphinx
docker-compose up -d
```

## index periodicity
```bash
0 6 * * SUN /usr/bin/bash /path/to/sphinx-docker/index.sh
```
