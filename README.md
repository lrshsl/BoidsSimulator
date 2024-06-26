# Boids Simulator in Nim

## Table of Contents  
- [Docs](#docs)
- [Getting started](#getting-started)
- [Features](#features)

## Docs

Docs are available at [docs/](lrshsl.github.io/BoidsSimulator).


## Getting started

### Binaries / Executables

Some binaries may be available in the releases. Use at own risk.

### Build from source

What needs to be installed:
- Git
- [Nim](https://nim-lang.org/) version 1.6 or higher (primarily developed for 2.0) (`nim` and `nimble` need to be available and in the path)
  - Recommended to be installed through `choosenim`, but also in the package repos of many distros
- [nimraylib_now](https://github.com/greenfork/nimraylib_now)
  - It's a nim package that includes [raylib](https://raylib.com) and nim bindings
  - Can easily be installed through `nimble install nimraylib_now`)


#### Linux or Mac (probably also works for BSD)

Download the source code:
```sh
git clone https://github.com/lrshsl/BoidsSimulator --branch hand_in_release
cd BoidsSimulator
```

Run using nimble:
```sh
nimble run
```

.. and hope it works!

The window shouldn't be resized while running. If different window dimensions are needed, the desired dimensions can be passed as arguments to the program.
```sh
nimble run -- 1000 800
```

Opimization options can be passed: `-d:release` for an optimized build or `-d:danger` for turning off even more checks to maximize performance (must be passed before the `--`)
```sh
nimble run -d:release -- 1000 800
```

##### Troubleshooting

Due to dynamic links in the raylib source code, it may be necessary to get some C x11 headers on your system.

Apt based distros (Debian, Ubuntu and distros based on those):
```sh
sudo apt install libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev libxinerama-dev libwayland-dev libxkbcommon-dev
```

Pacman (Arch linux):
```sh
sudo pacman -S alsa-lib mesa libx11 libxrandr libxi libxcursor libxinerama
```

Else consult the [raylib docs](https://github.com/raysan5/raylib?tab=readme-ov-file#build-and-installation).


#### Windows

1. Get an empty usb-stick
2. Flash it with a linux distro
3. Boot from it
4. Install Linux
5. See chapter Linux ;)


## Features

- [X] Basic boids simulation
- [X] Tunable parameters
  - Somehow tunable
    - [X] Window dimensions
    - [ ] Colors
    - [ ] Settings
      - [ ] Starting values
      - [ ] Presets of parameter values
    - [ ] Size of entities
  - UI with instant reloading
    - [X] Cohesion, align and separation factors
    - [X] Number of entities
    - [X] View radius
    - [X] Speed (max and min)
    - [X] Separation from the edges
    - [X] Ui behaviour
- [X] Fancy colors
- [ ] Optimizations

Current developement focus:
- Documentation
- Automatic screen size adaption
- Refactor code (comments and architecure)


