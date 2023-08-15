# virtual build for SPR

using `hashicorp/packer:latest` docker image.

## plugins
- DigitalOcean

# build with packer

```sh
export DIGITALOCEAN_API_TOKEN="TOKEN_HERE"
packer init .pkr.hcl
packer build template.json
```

# build with docker

```sh
export DIGITALOCEAN_API_TOKEN="TOKEN_HERE"

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
```

# TODO

- support other platforms
- github action
