# grafanyx makefile

# Environment Varibles
CONTAINER = grafanyx

.PHONY: up

prep :
	mkdir -p \
		data/whisper \
		data/elasticsearch \
		data/grafana \
		log/graphite \
		log/graphite/webapp \
		log/elasticsearch

pull :
	docker-compose pull

up : prep pull
	docker-compose up -d

down :
	docker-compose down

shell :
	docker exec -ti $(CONTAINER) /bin/bash

tail :
	docker logs -f $(CONTAINER)

docker :
	# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
	apt-get remove -y docker docker-engine docker.io docker-ce
	apt-get update
	sudo apt-get install -y \
    		apt-transport-https \
    		ca-certificates \
    		curl \
    		software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository \
   		"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get install -y docker-ce docker-compose
	sudo usermod -aG docker $USER
	sudo systemctl enable docker
