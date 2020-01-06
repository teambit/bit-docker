# Bit-docker

A dockerfile setup to run your own [Bit](https://www.github.com/teambit/bit) server.

## What's inside

- Prerequisite (git, ssh, node).
- Bit installation.
- SSH daemon setup.
- Bit bare server instantiation.

## Instruction

1. Clone this repository
1. Build image  
    `docker build . -t bit`
1. Setup a docker container to run a Bit bare server  
    `docker run --rm --name bit -d -P  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub bitcli/bit-docker`
1. Configure post for the Bit server  
    `docker port bit 2200`

> you can replace `bit` with any other `<container id>`.

## Working with a self-hosted Bit bare server

- Add the Bit bare server as a remote  
    `bit remote add ssh://root@localhost:2200:/tmp/scope -g`
- Access Bash and run commands on the Bit server container  
    `docker exec -it bit /bin/bash`
- See Bit logs from the container  
    `tail -f /root/Library/Caches/Bit/logs/debug.log`
- kill the container  
    `docker kill bit`

### Copy your own ssh key to the container

relevant in case when you are going to export a component which need to resolve the dependencies against private scopes in bit.dev

Copy your ssh key into the container (run command from your machine's bash)

`docker cp ~/.ssh/id_rsa bit:/root/.ssh/`

on the container bash:

`bit config ssh_key_file /root/.ssh/id_rsa`

## Run Bit server from a local build

To run a local container for development:

1. Clone the [Bit repository](https://www.github.com/teambit/bit).
1. Build the exec according to Bit's build instructions.
1. Run the following command  
    `docker run --rm --name bit -d -P  --volume <path to git-clone of bit>:/bit-bin  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub --env 'DEVELOPMENT=true' bitcli/bit-docker`

## Contributing

Contributions are always welcome, no matter how large or small.

## License

MIT License.
