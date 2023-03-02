# miniss

**miniss** (_mini ss_) displays a list of open listening sockets. It is a minimal alternative to `ss` or `netstat`.

The goal of **miniss** is not to reinvent the wheel but rather to offer a static binary that can be deployed by pentester or CTF players on containers or hardened environnement where the classical `ss` or `netstat` binaries have been removed.

## Installation

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
  - [ ] UDP
- IP version:
  - [x] IPv4
  - [ ] IPv6

## Author

- [noraj](https://pwn.by/noraj/) - creator and maintainer
