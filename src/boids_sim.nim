import boids_simpkg/lib as lib
import boids_simpkg/constants as constants

import os as os
from std/strutils import parseInt

## # Boids Simulator
## A simple boids simulator written in Nim
##
## See the [github repo](https://github.com/lrshsl/BoidsSimulator) for more information on installation and usage.


proc main*() =
  ## The main entry point of the program
  ## Responsible for environment setup (e.g. command line arguments) and initiating of the main loop
  ## Never returns

  # Parse the command line arguments
  case os.paramCount()
  of 0:
    # No arguments -> use the default values
    discard
  of 2:
    # 2 arguments -> parse as width and height
    constants.screenSize.x = os.paramStr(1).parseInt.float
    constants.screenSize.y = os.paramStr(2).parseInt.float
  else:
    # Too many arguments or only 1 argument -> exit
    echo "usage: boids_sim [screen_width screen_height]"
    quit(1)

  # Start the main loop
  lib.run(screenSize)


# Only execute if this file or project is run directly
when isMainModule:
  main()
