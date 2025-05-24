# Package

version       = "0.2.0"
author        = "lrshsl"
description   = "Simple boids simulator written in Nim"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["boids_sim"]


# Dependencies

requires "nim >= 1.6"
requires "nimraylib_now >= 0.15.0"
