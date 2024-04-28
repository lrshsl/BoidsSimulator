# Package

version       = "0.1.0"
author        = "lrshsl"
description   = "Simple boids simulator written in Nim"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["boids_sim"]


# Dependencies

requires "nim >= 2.0.2"
requires "nimraylib_now >= 0.15.0"
