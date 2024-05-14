import boids_simpkg/lib as lib
import boids_simpkg/constants as constants

from nimraylib_now import Vector2

import os as os
from std/strutils import parseInt

## # Boids Simulator
## A simple boids simulator written in Nim
##
## See the [github repo](https://github.com/lrshsl/BoidsSimulator) for more information on installation and usage.


proc main*() =
  ## The main entry point of the program

  # Parse the command line arguments
  case os.paramCount()
  of 0:
    # No arguments -> use the default values
    discard
  of 2:
    # 2 arguments -> parse as width and height
    constants.screenWidth = os.paramStr(1).parseInt
    constants.screenHeight = os.paramStr(2).parseInt
  else:
    # Too many arguments or only 1 argument -> exit
    echo "usage: boids_sim [screen_width screen_height]"
    quit(1)

  # Pack the screen size into a `Vector2`
  let screenSize = Vector2(x: screenWidth.float, y: screenHeight.float)

  # Start the main loop
  lib.run(screenSize)


# Only execute if this file or project is run directly
when isMainModule:
  main()
