# VirtualBox setup

1) Bump the video ram from default 10MiB to 128MiB or the video won't scale with guest additions.
2) Enable bidirectional shared clipboard.
3) Run this to install the required guest additions packages:
   ```bash
   sudo apt-get install virtualbox-guest-x11 build-essential
   ```
