import util
import util
import constants

import nimraylib_now

import std/sugar

proc getTriangleSize*(ui: Ui): Vector2 = triangleSize

# Meta parameters
proc getNumTriangles*(ui: Ui): int =
  ui.widgets[0].value.int

proc getViewRadius*(ui: Ui): float =
  ui.widgets[1].value

proc getEvadeEdgesFactor*(ui: Ui): float =
  ui.widgets[2].value

# Speed
proc getMinSpeed*(ui: Ui): float =
  ui.widgets[3].value

proc getMaxSpeed*(ui: Ui): float =
  ui.widgets[4].value

# Rule parameters
proc getSeparateFactor*(ui: Ui): float =
  ui.widgets[5].value

proc getAlignFactor*(ui: Ui): float =
  ui.widgets[6].value

proc getCohesionFactor*(ui: Ui): float =
  ui.widgets[7].value


