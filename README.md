# CS2 Server Template

## Running the container

Everything in the repository root will be copied into the container, so you can put plugins,
configuration files, etc. in the repo root and then install them in the container.

To start the server, run the following command:

```sh
$ docker compose up --build
```

## Installing CS2KZ

1. Follow the instructions in this repo: https://github.com/zer0k-z/cs2kz_metamod/tree/dev
2. Copy `build/package` from the cs2kz_metamod repo into `./cs2kz`
3. Rebuild the container and KZ should get installed automatically.
