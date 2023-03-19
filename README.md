# miniss

![GitHub Workflow Status (with branch)](https://img.shields.io/github/actions/workflow/status/noraj/miniss/test.yml?branch=master&style=flat-square)
![GitHub License](https://img.shields.io/github/license/noraj/miniss?style=flat-square)
![GitHub top language](https://img.shields.io/github/languages/top/noraj/miniss?style=flat-square)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/noraj/miniss?style=flat-square)

![miniss logo](docs/logo-miniss.png)

**miniss** (_mini ss_) displays a list of open listening sockets. It is a minimal alternative to `ss` or `netstat`.

The goal of **miniss** is not to reinvent the wheel but rather to offer a static binary that can be deployed by pentester or CTF players on containers or hardened environnement where the classical `ss` or `netstat` binaries have been removed.

## Installation

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/noraj/miniss?sort=semver&style=flat-square)
![GitHub tag (latest SemVer pre-release)](https://img.shields.io/github/v/tag/noraj/miniss?include_prereleases&sort=semver&style=flat-square)

TODO: Write installation instructions here

## Usage

```
./miniss
```

## Features

- Information displayed:
  - local address, remote address, state, username, uid
- Type of sockets:
  - [x] TCP
  - [x] UDP
- IP version:
  - [x] IPv4
  - [ ] IPv6

## Documentation

[![Library documentation](https://img.shields.io/badge/doc-library-black?logo=readthedocs&logoColor=black&style=flat-square)](https://noraj.github.io/miniss/lib-doc/Miniss.html)
[![User documentation - Build](https://img.shields.io/badge/doc-build-black?logo=readthedocs&logoColor=black&style=flat-square)](https://noraj.github.io/miniss/build)
[![User documentation - Changelog](https://img.shields.io/badge/doc-changelog-black?logo=readthedocs&logoColor=black&style=flat-square)](https://noraj.github.io/miniss/CHANGELOG)
[![Developer documentation - Contributing](https://img.shields.io/badge/doc-contributing-black?logo=readthedocs&logoColor=black&style=flat-square)](https://noraj.github.io/miniss/creating)
[![Developer documentation - Development](https://img.shields.io/badge/doc-development-black?logo=readthedocs&logoColor=black&style=flat-square)](https://noraj.github.io/miniss/development)
[![User documentation - TODO](https://img.shields.io/badge/doc-todo-black?logo=readthedocs&logoColor=black&style=flat-square)](https://noraj.github.io/miniss/TODO)

## Author

- [noraj](https://pwn.by/noraj/) - creator and maintainer
