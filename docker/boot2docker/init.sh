
#!/bin/sh

echo "Start to install docker compose ..."
docker_compose_version=1.18.0
sudo curl -L https://github.com/docker/compose/releases/download/$docker_compose_version/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
