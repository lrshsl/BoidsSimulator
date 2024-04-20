import boids_simpkg/rules
import boids_simpkg/util

import nimraylib_now

import random
import math
import system/iterators

const
  (ScreenWidth, ScreenHeight) = (1800, 900)

proc triangleVertices(t: Triangle): (Vector2, Vector2, Vector2) = (
    t.pos + Up.rotate(t.heading + PI/2) * triangleSize.y * 2/3,
    t.pos + Left.rotate(t.heading + PI/2) * triangleSize.x * 0.5 + Down.rotate(t.heading + PI/2) * triangleSize.y * 1/3,
    t.pos + Right.rotate(t.heading + PI/2) * triangleSize.x * 0.5 + Down.rotate(t.heading + PI/2) * triangleSize.y * 1/3)

proc generateTriangles(n: int): seq[Triangle] =
  for i in 0..<n:
    let
      heading = rand(2 * PI)
      speed = rand(minSpeed..maxSpeed)
      (w, h) = triangleSize.tuple
      x = rand(w..(ScreenWidth.float - w))
      y = rand(h..(ScreenHeight.float - h))
    result.add(Triangle(
      pos: Vector2(x: x, y: y),
      vel: Vector2.fromRad(heading) * speed,
    ))

proc moveTriangles(triangles: var seq[Triangle], dt: float) =
  for t in triangles.mitems:
    t.pos += t.vel * dt

#proc evadeEdges(triangles: var seq[Triangle]) =
#  let screen = Rectangle(x: 0.0, y: 0.0,
#                       width: ScreenWidth.float,
#                       height: ScreenHeight.float)
#  for t in triangles.mitems:
#    if t.pos.x < screen.x - viewRadius:
#      t.vel.x *= -1
#    elif t.pos.x > screen.x + screen.width + viewRadius:
#      t.targetHeading = t.pos.headingTowards(t.pos.withX(screen.x + screen.width))
#    elif t.pos.y < screen.y - viewRadius:
#      t.targetHeading = t.pos.headingTowards(t.pos.withY(screen.y)) - PI
#    elif t.pos.y > screen.y + screen.height + viewRadius:
#      t.targetHeading = t.pos.headingTowards(t.pos.withY(screen.y + screen.height))

proc drawTriangles(triangles: seq[Triangle], color: Color) =
  for t in triangles:
    let (a, b, c) = triangleVertices(t)
    drawTriangle(a, b, c, color)

func dt(): float = getFrameTime()

when isMainModule:
  initWindow(ScreenWidth, ScreenHeight, "Boids Sim")
  setTargetFPS(60)

  var
    triangles = generateTriangles(NumTriangles)

  while not windowShouldClose():
    let dt = dt()
    #rule_align(triangles, dt)
    #rule_separate(triangles, 20.0, dt)
    rule_cohesion(triangles, dt)

    moveTriangles(triangles, dt)
    #evadeEdges(triangles)

    beginDrawing()
    drawCircleLines(centerOfMass(triangles).x.int, centerOfMass(triangles).y.int, 5, Red)
    clearBackground(Black)
    drawTriangles(triangles, Yellow)
    drawFPS(10, 10)
    endDrawing()

  closeWindow()
  echo "<<Done>>"
