#!/bin/sh

# init packer with docean plugin
docker run \
	--rm \
	-it \
	-v `pwd`:/workspace -w /workspace \
	-e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
	hashicorp/packer:latest \
	init .

# build spr image
docker run \
	--rm \
	-it \
	-v `pwd`:/workspace -w /workspace \
	-e DIGITALOCEAN_API_TOKEN="$DIGITALOCEAN_API_TOKEN" \
	-e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
	hashicorp/packer:latest \
	build template.json
