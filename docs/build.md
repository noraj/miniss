# Build

## Static

To deploy the binary on the target we need a static build.

Install dependencies:

```sh
shards install --production
```

As the [Crystal documentations](https://crystal-lang.org/reference/1.21/man/crystal/index.html#creating-a-statically-linked-executable) says:

> Building fully statically linked executables is currently only supported on Alpine Linux.

For that purpose, the [documentation](https://crystal-lang.org/reference/1.21/guides/static_linking.html#musl-libc) recommends using `musl-libc`:

> Official [Docker Images based on Alpine Linux](https://crystal-lang.org/2020/02/02/alpine-based-docker-images.html) are available on Docker Hub at [crystallang/crystal](https://hub.docker.com/r/crystallang/crystal/). The latest release is tagged as crystallang/crystal:latest-alpine.

As an example replace the local build:

```sh
crystal build src/miniss.cr --release --static --no-debug -o bin/miniss
shards build --production --release --static --no-debug miniss
```

with

```sh
docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.21.0-alpine \
    crystal build src/miniss.cr --release --static --no-debug -o bin/miniss

docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.21.0-alpine \
    shards build --production --release --static --no-debug miniss
```

Since you are cross-compiling from a docker container, it would be wiser to ensure to provide the correct [cross compilation flags](https://crystal-lang.org/reference/1.21/syntax_and_semantics/cross-compilation.html).

Find your platform with `llvm-config --host-target` (examples: `x86_64-pc-linux-gnu` on a modern Linux host) on your host or the target (see [platform support](https://crystal-lang.org/reference/1.21/syntax_and_semantics/platform_support.html) and [LLVM - Cross-compilation using Clang](https://clang.llvm.org/docs/CrossCompilation.html)).

So change from

```sh
crystal build src/miniss.cr --release --static --no-debug -o bin/miniss --cross-compile --target x86_64-pc-linux-gnu
cc bin/miniss.o -o bin/miniss -rdynamic -static --no-debug -L/home/noraj/.asdf/installs/crystal/1.21.0/bin/../lib/crystal -lpcre -lm -lgc -lpthread -levent -lrt -lpthread -ldl
```

to

```sh
docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.21.0-alpine \
    crystal build src/cli.cr --release --static --no-debug \
   -o bin/miniss-x86_64-pc-linux-gnu --cross-compile --target x86_64-pc-linux-gnu
cc bin/miniss-x86_64-pc-linux-gnu.o -o bin/miniss-x86_64-pc-linux-gnu -rdynamic -static -L/usr/bin/../lib/crystal -lpcre -lm -lgc -lpthread -levent -lrt -lpthread -ldl
```

Note: the second line must be executed on the target platform.

Finally, check your binary is fully static:

```sh
ldd bin/miniss-x86_64-pc-linux-gnu
#        not a dynamic executable
```

Static builds than can be made 100% with docker:

```sh
# x86_64-linux-musl
docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:latest-alpine \
    crystal build src/cli.cr --release --static --no-debug \
   -o bin/miniss-x86_64-linux-musl --target x86_64-linux-musl
# x86_64-linux-gnu
docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:latest \
    crystal build src/cli.cr --release --static --no-debug \
   -o bin/miniss-x86_64-linux-gnu --target x86_64-linux-gnu
```

## Dynamic

If you like `miniss` very much and want to use it on your system as well.

Install dependencies:

```sh
shards install --production
```

Build:

```sh
crystal build src/miniss.cr --release --no-debug -o bin/miniss
shards build --production --release --no-debug
```

## Release

This we you can compile a pre-compiled object without needing Crystal, Docker or managing the dependencies.

### 64-bit Linux (kernel 2.6.18+, GNU libc)

```sh
cc miniss-x86_64-linux-gnu.o -o miniss-x86_64-linux-gnu -rdynamic -static -L/usr/lib/crystal -lpcre -lm -lgc -lpthread -levent -lrt -lpthread -ldl
```

### ARM 64-bit Linux (GNU libc, hardfloat)

```sh
cc miniss-aarch64-linux-gnu.o -o miniss-aarch64-linux-gnu -rdynamic -static -L/usr/lib/crystal -lpcre -lm -lgc -lpthread -levent -lrt -lpthread -ldl
```

### ARM 64-bit Linux (MUSL libc, hardfloat)

```sh
cc miniss-aarch64-linux-musl.o -o miniss-aarch64-linux-musl -rdynamic -static -L/usr/lib/crystal -lpcre -lgc -levent
```

### ARM 32-bit Linux (GNU libc, hardfloat)

Dependencies Debian 11: `apt install libpcre3-dev libgc-dev libevent-dev`

```sh
cc miniss-arm-linux-gnueabihf.o -o miniss-arm-linux-gnueabihf -rdynamic -static -L/usr/lib/crystal -lpcre -lm -lgc -lpthread -levent -lpthread -ldl
```

### 32-bit Linux (kernel 2.6.18+, GNU libc)

```sh
cc miniss-i386-linux-gnu.o -o miniss-i386-linux-gnu -rdynamic -static -L/usr/lib/crystal -lpcre -lm -lgc -lpthread -levent -lrt -lpthread -ldl
```

### 32-bit Linux (MUSL libc)

```sh
cc miniss-i386-linux-musl.o -o miniss-i386-linux-musl -rdynamic -static -L/usr/lib/crystal -lpcre -lgc -levent
```

### 64-bit Linux (MUSL libc)

```sh
cc miniss-x86_64-linux-musl.o -o miniss-x86_64-linux-musl -rdynamic -static -L/usr/lib/crystal -lpcre -lgc -levent
```

### 64-bit OpenBSD (6.x)

```sh
cc miniss-x86_64-openbsd.o -o miniss-x86_64-openbsd -rdynamic -static -L/usr/lib/crystal -lpcre -lm -lgc -lpthread -levent_extra -levent_core -lc++abi -lpthread -liconv
```

### 64-bit FreeBSD (12.x)

```sh
cc miniss-x86_64-freebsd.o -o miniss-x86_64-freebsd -rdynamic -static -L/usr/lib/crystal -lpcre -lm -lgc-threaded -lpthread -levent -lpthread
```
