# Install

## Manual

For `x86_64-linux-gnu`, a pre-compiled static binary is available, see [releases](https://github.com/noraj/miniss/releases). Else you can [build](build.md) one.

Rename the binary `miniss` and put it somewhere under your PATH.

## ArchLinux

AUR: [miniss](https://aur.archlinux.org/packages/miniss)

Manually:

```
$ git clone https://aur.archlinux.org/miniss.git
$ cd miniss
$ makepkg -sic
```

With an AUR helper ([Pacman wrappers](https://wiki.archlinux.org/index.php/AUR_helpers#Pacman_wrappers)), eg. pikaur:

```
$ pikaur -S miniss
```
