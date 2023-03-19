Compile:

https://github.com/crystal-lang/crystal/issues/9285#issuecomment-1445493032

```
crystal build src/cli.cr --release --static --no-debug -o bin/miniss
shards build --production --release --static --no-debug

docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    crystal build src/cli.cr --release --static --no-debug -o bin/miniss
docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    shards build --production --release --static --no-debug

$ llvm-config --host-target
$ docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    crystal build src/cli.cr --release --static --no-debug \
    -o bin/miniss-x86_64-pc-linux-gnu --cross-compile --target x86_64-pc-linux-gnu
$ docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    cc bin/miniss-x86_64-pc-linux-gnu.o -o bin/miniss-x86_64-pc-linux-gnu -rdynamic -static -L/usr/bin/../lib/crystal -lpcre -lm -lgc -lpthread -levent -lrt -lpthread -ldl
```

