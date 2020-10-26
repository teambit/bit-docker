# Bit-docker

A dockerfile setup to run your own [Bit](https://www.github.com/teambit/bit) server.  
If you want to setup a bare-bone Bit remote server without Docker, please refer to [this guide](https://docs.bit.dev/docs/bit-server).

## Getting started

1. Clone this repository.  
1. Edit `scope.json` with your name (legacy, shoudl be replaced soon)
1. Edit `scope.jsonc` with your description
1. Build image and run server.  
    ```sh
    $ docker build . -t harmony-scope
    $ docker run --rm --name my-scope -d -p 3000:3000 harmony-scope
    ```
    Note - the server will take a few minutes to spin up, so localhost:3000 wont be available immediately
1. Configure workspace to use the server.  
    ```sh
    $ bit remote add http://localhost:3000
    ```
1. Add scope to `workspace.jsonc`
1. Export components to a Bit server.  
    ```sh
    $ bit export
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
- Make sure the HTTP port is configured correctly.  
    ```sh
    $ docker port bit 3000
    ```
- See that your server is configured for your workspace.  
    ```sh
    $ bit remote
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

## Contributing

Contributions are always welcome, no matter how large or small.

## License

MIT License.
