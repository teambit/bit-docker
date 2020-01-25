# Bit-docker

A dockerfile setup to run your own [Bit](https://www.github.com/teambit/bit) server.  
If you want to setup a bare-bone Bit remote server without Docker, please refer to [this guide](https://docs.bit.dev/docs/bit-server).

## Getting started

1. Clone this repository.  
1. Build image and run server.  
    ```sh
    $ docker build . -t bit
    $ docker run --rm --name bit -d -P  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub bitcli/bit-docker
    $ docker port bit 22
    ```
1. Configure workspace to use the server.  
    ```sh
    $ bit remote add ssh://root@<hostname>:22:/tmp/scope -g
    ```
1. Export components to a Bit server.  
    ```sh
    $ bit export scope
    ```
1. Import components from a Bit server.  
    ```sh
    $ bit import scope.<component-name>
    ````
1. Stop server  
    ```sh
    $ docker kill bit
    ```

## Troubleshooting

### Unable to connect to server

- See if container is running.  
    ```sh
    $ docker ps --all | grep bit
    ```
- Make the SSH port is configured correctly.  
    ```sh
    $ docker port bit 22
    ```
- See that your server is configured for your workspace.  
    ```sh
    $ bit remote
    ```
    
### Unable to import/export

Bit uses SSH for networking. This setup [mounts your user account SSH keys](https://github.com/teambit/bit-docker/blob/master/Dockerfile#L24).  
To manually set up authentication, or authenticate another key:

1. Copy a public key to the container.  
    ```sh
    $ docker cp ~/.ssh/id_rsa bit:/root/.ssh/
    ```
1. Run bash on the container.  
    ```sh
    $ docker exec -it bit /bin/bash
    ```
1. Configure the container's SSH daemon with the new key (run from container's bash).  
    ```sh
    $ bit config ssh_key_file /root/.ssh/id_rsa
    ```

### Run bash on the container

When you need to run any command on the Bit server, you first need to get bash on the container:

```sh
$ docker exec -it bit /bin/bash
```

Now each command you run, runs on the server.

### Tail server logs

To run the `tail` command and get the server's logs, you should first [get bash on the container](#run-bash-on-the-container). Then `tail` Bit's log:

```sh
$ tail -f /root/Library/Caches/Bit/logs/debug.log
```

## For maintainers - Run server from a local build

After building Bit from source code, run this command:

```sh
$ docker run --rm --name bit -d -P  --volume <path to git-clone of bit>:/bit-bin  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub --env 'DEVELOPMENT=true' bitcli/bit-docker
```

## Contributing

Contributions are always welcome, no matter how large or small.

## License

MIT License.
