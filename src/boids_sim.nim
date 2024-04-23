import boids_simpkg/rules
import boids_simpkg/ui
import boids_simpkg/util

import nimraylib_now

import random
import math
import system/iterators

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

proc evadeEdges(triangles: var seq[Triangle]) =
  let screen = Rectangle(x: 0.0, y: 0.0,
                       width: ScreenWidth.float,
                       height: ScreenHeight.float)
  for t in triangles.mitems:
    let
      distanceLeft = t.pos.x - screen.x
      distanceRight = screen.x + screen.width - t.pos.x
      distanceTop = t.pos.y - screen.y
      distanceBottom = screen.y + screen.height - t.pos.y

    if distanceLeft < viewRadius:
      t.vel.x += (viewRadius - distanceLeft) * evadeEdgesFactor
    elif distanceRight < viewRadius:
      t.vel.x += -(viewRadius - distanceRight) * evadeEdgesFactor
    elif distanceTop < viewRadius:
      t.vel.y += (viewRadius - distanceTop) * evadeEdgesFactor
    elif distanceBottom < viewRadius:
      t.vel.y += -(viewRadius - distanceBottom) * evadeEdgesFactor

func getColor(i, n: int): Color =
  case i mod 9
    of 0: Red
    of 1: Orange
    of 2: Yellow
    of 3: Green
    of 4: Blue
    of 5: Purple
    of 6: Violet
    of 7: White
    of 8: Black
    else: White

proc drawTriangles(triangles: seq[Triangle]) =
  for t in triangles:
    let
      (a, b, c) = triangleVertices(t)
      cHeading = PI - abs(t.heading)
      cval = uint8(cHeading * 255.0 / PI)
      color = Color(r: 0, g: 255 - cval, b: cval, a: 255)
    drawTriangle(a, b, c, color)

func dt(): float = getFrameTime()

when isMainModule:
  initWindow(ScreenWidth, ScreenHeight, "Boids Sim")
  setTargetFPS(60)

  var
    triangles = generateTriangles(NumTriangles)

  while not windowShouldClose():
    let dt = dt()

    ### Input ###
    mainUi.update()

    ### Rules ###
    apply_rules(triangles, dt)
    evadeEdges(triangles)

    moveTriangles(triangles, dt)

    ### Draw ###
    beginDrawing()

    # Clear
    clearBackground(Black)
    # View radius
    drawCircleLines(triangles[0].pos.x.int, triangles[0].pos.y.int, viewRadius, Green)
    # Triangles
    drawTriangles(triangles)
    # User interface
    mainUi.draw()
    drawFPS(10, 10)

    endDrawing()

  closeWindow()
  echo "<<Done>>"

