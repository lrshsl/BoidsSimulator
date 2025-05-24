
import boids_sim

import unittest
import math

test "getOptimalTurnChange":
  check getOptimalTurnChange(0, 0) == 0
  check getOptimalTurnChange(0, PI/2) == PI/2
  check getOptimalTurnChange(0, -PI/2) == -PI/2
  check getOptimalTurnChange(0, PI/3) == PI/3
  check getOptimalTurnChange(0, -PI/3) == -PI/3

test "weirderTurnChange":
  check getOptimalTurnChange(PI/2, 0) == -PI/2
  check getOptimalTurnChange(PI/2, -PI/2) == PI or
    getOptimalTurnChange(PI/2, -PI/2) == -PI
  check getOptimalTurnChange(PI/2, PI) == PI/2
  check getOptimalTurnChange(PI/2, -PI) == PI/2

