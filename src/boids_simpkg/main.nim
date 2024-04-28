import rules
import ui_functions
import main_ui
import parameters
import constants
import util

import nimraylib_now

import random
import math
import system/iterators
import std/sugar

proc triangleVertices(t: Triangle, ui: Ui): (Vector2, Vector2, Vector2) =
    let (w, h) = getTriangleSize(ui).tuple
    (t.pos + Up.rotate(t.heading + PI/2) * h * 2/3,
     t.pos + Left.rotate(t.heading + PI/2) * w * 0.5 + Down.rotate(t.heading + PI/2) * h * 1/3,
     t.pos + Right.rotate(t.heading + PI/2) * w * 0.5 + Down.rotate(t.heading + PI/2) * h * 1/3)

proc generateTriangles(n: int, ui: Ui): seq[Triangle] =
  for i in 0..<n:
    let
      heading = rand(2 * PI)
      speedRange = getMinSpeed(ui)..getMaxSpeed(ui)
      speed = rand(speedRange)
      (w, h) = getTriangleSize(ui).tuple
      x = rand(w..(ScreenWidth.float - w))
      y = rand(h..(ScreenHeight.float - h))
    result.add(Triangle(
      pos: Vector2(x: x, y: y),
      vel: Vector2.fromRad(heading) * speed,
    ))

func moveTriangles(triangles: var seq[Triangle], dt: float) =
  for t in triangles.mitems:
    t.pos += t.vel * dt

proc evadeEdges(triangles: var seq[Triangle], ui: Ui) =
  let screen = Rectangle(x: 0.0, y: 0.0,
                       width: ScreenWidth.float,
                       height: ScreenHeight.float)
  for t in triangles.mitems:
    let
      vr = getViewRadius(ui)
      f = getEvadeEdgesFactor(ui)
      distanceLeft = t.pos.x - screen.x
      distanceRight = screen.x + screen.width - t.pos.x
      distanceTop = t.pos.y - screen.y
      distanceBottom = screen.y + screen.height - t.pos.y

    if distanceLeft < vr:
      t.vel.x += (vr - distanceLeft) * f
    elif distanceRight < vr:
      t.vel.x += -(vr - distanceRight) * f
    elif distanceTop < vr:
      t.vel.y += (vr - distanceTop) * f
    elif distanceBottom < vr:
      t.vel.y += -(vr - distanceBottom) * f

proc drawTriangles(triangles: seq[Triangle], ui: Ui) =
  for t in triangles:
    let
      (a, b, c) = triangleVertices(t, ui)
      cHeading = PI - abs(t.heading)
      cval = uint8(cHeading * 255.0 / PI)
      color = Color(r: 0, g: 255 - cval, b: cval, a: 255)
    drawTriangle(a, b, c, color)

func dt(): float = getFrameTime()

proc main*() =
  initWindow(ScreenWidth, ScreenHeight, "Boids Sim")
  setTargetFPS(60)

  var
    mainUi = setupMainUi()
    triangles = generateTriangles(mainUi.getNumTriangles(), mainUi)

  while not windowShouldClose():
    let dt = dt()

    ### Input ###
    mainUi.update()

    ### Rules ###
    apply_rules(triangles, mainUi, dt)
    evadeEdges(triangles, mainUi)
    moveTriangles(triangles, dt)

    ### Update Triangles ###
    let delta = mainUi.getNumTriangles() - triangles.len
    if delta > 0:
      triangles &= generateTriangles(delta, mainUi)
    elif delta < 0:
      triangles.setLen(triangles.len + delta)

    ### Draw ###
    beginDrawing()

    # Clear
    clearBackground(Black)
    # View radius
    drawCircleLines(triangles[0].pos.x.int, triangles[0].pos.y.int, mainUI.getViewRadius, White)
    # Triangles
    drawTriangles(triangles, mainUi)
    # Color the first triangle differently
    let (a, b, c) = triangleVertices(triangles[0], mainUi)
    drawTriangle(a, b, c, White)
    # User interface
    mainUi.draw()
    drawFPS(10, 10)

    endDrawing()

  closeWindow()
  echo "<<Done>>"







