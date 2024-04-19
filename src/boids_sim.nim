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
    let heading = rand(2 * PI)
    result.add(Triangle(
      pos: Vector2(x: rand(ScreenWidth.float - triangleSize.x),
                   y: rand(ScreenHeight.float - triangleSize.y)),
      heading: heading,
      targetHeading: heading,
      speed: rand(minSpeed..maxSpeed)
    ))

func getOptimalTurnChange*(current, target: float): float =
  result = target - current
  if result > PI:
    result -= 2 * PI
  if result < -PI:
    result += 2 * PI

proc turnTriangles(triangles: var seq[Triangle], turnSpeed, dt: float) =
  for t in triangles.mitems:
    var change = getOptimalTurnChange(t.heading, t.targetHeading)
    t.heading += change * turnSpeed * dt

proc moveTriangles(triangles: var seq[Triangle], dt: float) =
  for t in triangles.mitems:
    t.pos.x += cos(t.heading) * t.speed * dt
    t.pos.y += sin(t.heading) * t.speed * dt

proc evadeEdges(triangles: var seq[Triangle]) =
  let
    screen = Rectangle(x: 0.0, y: 0.0,
                       width: ScreenWidth.float,
                       height: ScreenHeight.float)
  for t in triangles.mitems:
    if t.pos.x < screen.x - evadeEdgesMargin:
      t.targetHeading = t.pos.headingTowards(t.pos.withX(screen.x)) - PI
    elif t.pos.x > screen.x + screen.width + evadeEdgesMargin:
      t.targetHeading = t.pos.headingTowards(t.pos.withX(screen.x + screen.width))
    elif t.pos.y < screen.y - evadeEdgesMargin:
      t.targetHeading = t.pos.headingTowards(t.pos.withY(screen.y)) - PI
    elif t.pos.y > screen.y + screen.height + evadeEdgesMargin:
      t.targetHeading = t.pos.headingTowards(t.pos.withY(screen.y + screen.height))

proc drawTriangles(triangles: seq[Triangle], color: Color) =
  for t in triangles:
    let (a, b, c) = triangleVertices(t)
    drawTriangle(a, b, c, color)

func dt(): float = getFrameTime()

when isMainModule:
  initWindow(ScreenWidth, ScreenHeight, "Boids Sim")
  setTargetFPS(60)

  var
    triangles = generateTriangles(400)

  while not windowShouldClose():
    let dt = dt()
    rule_align(triangles, dt)
    #rule_separate(triangles, 20.0, dt)
    #rule_cohesion(triangles, dt)

    turnTriangles(triangles, turnSpeed, dt)
    moveTriangles(triangles, dt)
    evadeEdges(triangles)

    beginDrawing()
    drawCircleLines(centerOfMass(triangles).x.int, centerOfMass(triangles).y.int, 5, Red)
    clearBackground(Black)
    drawTriangles(triangles, Yellow)
    drawFPS(10, 10)
    endDrawing()

  closeWindow()
  echo "<<Done>>"
