## Development

### Documentation

Regenerate the documentation

```
crystal docs --output=docs/lib-doc
```

Ref.

- [Crystal doc - Documenting code](https://crystal-lang.org/reference/1.7/syntax_and_semantics/documenting_code.html)
- [Crystal doc - Using the compiler `crystal docs`](https://crystal-lang.org/reference/1.7/man/crystal/#crystal-docs)

### Linting

[ameba](https://github.com/crystal-ameba/ameba) is used as a linter.

`shards install` will install it under `./bin/ameba`.

### Test

Run all test suites:

```
crystal spec --order=random --error-on-warnings
```

Ref.

- [Crystal doc - Testing Crystal Code](https://crystal-lang.org/reference/1.7/guides/testing.html)
- [Crystal api - Spec](https://crystal-lang.org/api/1.7.2/Spec.html)
