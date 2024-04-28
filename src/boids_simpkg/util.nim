import nimraylib_now

import math

# Triangle
type
  Triangle* = object
    pos*: Vector2
    vel*: Vector2

func heading*(t: Triangle): float =
  arctan2(t.vel.y, t.vel.x)

# Vector2 extensions
func `tuple`*(v: Vector2): (float, float) =
  (v.x.float, v.y.float)

func ints*(v: Vector2): (int, int) =
  (v.x.int, v.y.int)

func fromRad*(_: typedesc[Vector2], radians: float): Vector2 =
  Vector2(x: cos(radians), y: sin(radians))

func headingTowards*(pos: Vector2, target: Vector2): float =
  let
    dx = target.x - pos.x
    dy = target.y - pos.y
  arctan2 dy, dx

func withX*(v: Vector2, x: float): Vector2 =
  Vector2(x: x, y: v.y)

func withY*(v: Vector2, y: float): Vector2 =
  Vector2(x: v.x, y: y)

