import util

import nimraylib_now

import std/sugar

type
  Ui = object
    widgets: seq[Widget]
  Widget = object
    pos: Vector2
    size: Vector2
    color: Color

proc newWidget(pos, size: Vector2 = Vector2(x: 0, y: 0), color: Color = White): Widget =
  Widget(pos: Vector2(x: 0, y: 0), size: Vector2(x: 0, y: 0), color: White)

const
  numWidgetsFirstRow = 3
  margin = 20
  firstRowStart = Vector2(x: margin, y: margin)
  widgetWidth = (ScreenWidth.float - 2 * margin) / numWidgetsFirstRow.float
  widgetHeight = 200
  widgetSize = Vector2(x: widgetWidth, y: widgetHeight)
  color = Gray

const
  widgets = collect:
    for i in 0 ..< numWidgetsFirstRow:
      newWidget(
          firstRowStart.withX(margin + widgetWidth * i.float),
          widgetSize,
          color)
var
  mainUi* = Ui(widgets: widgets)

proc `draw`*(ui: Ui) =
  for w in ui.widgets:
    drawRectangle(w.pos.x.int, w.pos.y.int,
                  w.size.x.int, w.size.y.int, w.color)

proc `update`*(ui: var Ui) = discard
