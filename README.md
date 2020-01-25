# Bit-docker

A dockerfile setup to run your own [Bit](https://www.github.com/teambit/bit) server.  
If you want to setup a bare-bone Bit remote server without this dockerfile, please refer to [this guide]](https://docs.bit.dev/docs/bit-server).

## What's inside

- All prerequisite.
- Bit installation and server setup.
- SSH authentication setup.

## Setting up a Bit server using docker

> note - you need to have docker installed on your machine.

1. Clone this repository.  
    `git clone git@github.com:teambit/bit-docker.git`
1. Build image.  
    `docker build . -t bit`
1. Start server.  
    `docker run --rm --name bit -d -P  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub bitcli/bit-docker`
1. Configure SSH port.  
    `docker port bit 22`
1. Stop server.  
    `docker kill bit`

## Working with a Bit server

For more information, see [this guide](https://docs.bit.dev/docs/bit-server#working-with-remote-scopes).

1. Configure workspace to use the server.  
    `bit remote add ssh://root@<hostname>:22:/tmp/scope -g`
1. Export components to a Bit server.  
    `bit export scope`
1. Import components from a Bit server.  
    `bit import scope.<component-name>`

## Troubleshooting

### Run bash on the container

When you need to run any command on the Bit server, you first need to get bash on the container:

```sh
docker exec -it bit /bin/bash
```

Now each command you run, runs on the server.

### Tail server logs

To run the `tail` command and get the server's logs, you should first [get bash on the container](#run-bash-on-the-container). Then `tail` Bit's log:

```sh
tail -f /root/Library/Caches/Bit/logs/debug.log
```

### Permissions errors on import/export

Bit uses SSH as a communication protocol. This dockerfile automates the SSH setup by mounting your [user account SSH keys](https://github.com/teambit/bit-docker/blob/master/Dockerfile#L24).  
To manually set up authentication, or authenticate another key:

1. Copy a public key to the container.  
    `docker cp ~/.ssh/id_rsa bit:/root/.ssh/`
1. Run bash on the container.  
    `docker exec -it bit /bin/bash`
1. Configure the container's SSH daemon with the new key (run from container's bash).  
    `bit config ssh_key_file /root/.ssh/id_rsa`

## For maintainers - Run Bit server from a local build

To run a local container for development:

1. Clone the [Bit repository](https://www.github.com/teambit/bit).
1. Build the exec according to Bit's build instructions.
1. Run the following command  
    `docker run --rm --name bit -d -P  --volume <path to git-clone of bit>:/bit-bin  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub --env 'DEVELOPMENT=true' bitcli/bit-docker`

## Contributing

Contributions are always welcome, no matter how large or small.

## License

MIT License.
