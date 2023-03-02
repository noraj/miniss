Compile:

https://github.com/crystal-lang/crystal/issues/9285#issuecomment-1445493032

```
crystal build src/miniss.cr --release --static -o bin/miniss
shards build --release --static

docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    crystal build src/miniss.cr --release --static -o bin/miniss
docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    shards build --release --static

$ llvm-config --host-target
$ docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    crystal build src/miniss.cr --release --static -o bin/miniss --cross-compile --target x86_64-pc-linux-gnu
$ docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.2-alpine \
    cc bin/miniss.o -o bin/miniss -rdynamic -static -L/usr/bin/../lib/crystal -lpcre -lm -lgc -lpthread -levent -lrt -lpthread -ldl
```

