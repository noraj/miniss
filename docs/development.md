# Development

## Documentation

Regenerate the documentation

```sh
crystal docs --output=docs/lib-doc
```

Ref.

- [Crystal doc - Documenting code](https://crystal-lang.org/reference/1.21/syntax_and_semantics/documenting_code.html)
- [Crystal doc - Using the compiler `crystal docs`](https://crystal-lang.org/reference/1.21/man/crystal/#crystal-docs)

## Linting

[ameba](https://github.com/crystal-ameba/ameba) is used as a linter.

`shards build ameba` will install it under `./bin/ameba`, else run `lib/ameba/bin/ameba.cr` directly.

## Test

Run all test suites:

```sh
crystal spec --order=random --error-on-warnings
```

Ref.

- [Crystal doc - Testing Crystal Code](https://crystal-lang.org/reference/1.21/guides/testing.html)
- [Crystal api - Spec](https://crystal-lang.org/api/1.21.0/Spec.html)

## Running

Build and execute in one command:

```sh
shards run miniss
```
