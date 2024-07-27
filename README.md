# VirtualBox setup

First, the guest additions video driver doesn't work without more video ram. It starts at 10MiB, but you can put it up to 128MiB.

Here's how to install it on ubuntu&derivatives:

```bash
sudo apt-get install virtualbox-guest-x11 build-essential
```
