# Mission Impossible: Android Hardening

This repository is intended to help build and install an `update.zip`
file that can be used to update a fresh CM11 according to [this tutorial
published by the Tor Project][article].

## Requirements

- `adb` CLI tool
- `wget` CLI tool

## Install

    make cm_dl_link

## Build

    make download_apks
    make package
    make goto_fastboot
    make push

Scratch scripts and notes, to be organized later, are stored in
`scratch.sh`. Oddly enough, this script is not yet intended to be run.


<!-- Links -->
   [tutorial]: https://trac.torproject.org/projects/tor/wiki/doc/HardeningAndroid#BasebandRemoval
