import nimraylib_now
import math

const
  Up* = Vector2(x: 0, y: -1)
  Down* = Vector2(x: 0, y: 1)
  Right* = Vector2(x: 1, y: 0)
  Left* = Vector2(x: -1, y: 0)

# Parameters
var
  triangleSize* = Vector2(x: 15, y: 30) # width, height
  NumTriangles* = 50
  minSpeed* = 70.0
  maxSpeed* = 150.0
  viewRadius* = 100.0
  separateFactor* = 1.0
  alignFactor* = 1.0
  cohesionFactor* = 1.0

# Triangle
type
  Triangle* = object
    pos*: Vector2
    vel*: Vector2

func `heading`*(t: Triangle): float =
  arctan2(t.vel.y, t.vel.x)

# Vector2 extensions
func `tuple`*(v: Vector2): (float, float) =
  (v.x.float, v.y.float)

func `fromRad`*(_: typedesc[Vector2], radians: float): Vector2 =
  Vector2(x: cos(radians), y: sin(radians))

func `headingTowards`*(pos: Vector2, target: Vector2): float =
  let
    dx = target.x - pos.x
    dy = target.y - pos.y
  arctan2(dy, dx)

func `withX`*(v: Vector2, x: float): Vector2 =
  Vector2(x: x, y: v.y)

func `withY`*(v: Vector2, y: float): Vector2 =
  Vector2(x: v.x, y: y)

