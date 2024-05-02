# Boids Simulator in Nim


## Getting started

### Binaries / Executables
Some binaries may be available in the releases. Use on own risk.


### Build from source
What needs to be installed:
- Nim (`nim` and `nimble` need to be available and in the path)
- [nimraylib_now](https://github.com/greenfork/nimraylib_now)
  - It's a nim package that includes [raylib](https://raylib.com) and Nim bindings
  - Can easily be installed through `nimble install nimraylib_now`)


#### Linux

Due to dynamic links in the raylib source code, it may be necessary to get some C x11 headers on your system.

Apt based distros (Debian, Ubuntu and distros based on those):
```sh
sudo apt install libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev libxinerama-dev libwayland-dev libxkbcommon-dev
```

Pacman:
```sh
sudo pacman -S alsa-lib mesa libx11 libxrandr libxi libxcursor libxinerama
```


#### Windows

1. Get an empty usb-stick
2. Flash it with a linux distro
3. Boot from it
4. Install Linux
5. See chapter Linux ;)

