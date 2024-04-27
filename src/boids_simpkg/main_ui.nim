import constants
import util

import nimraylib_now

import std/sugar

const
  numWidgetsPerRow = 5
  margin = 20.0
  firstRowStart = Vector2(x: margin, y: margin)

  bgColor = Black
  textColor = White
  fillColor = Green
  borderColor = White
  showSliderName = true
  showSliderValue = true
  sliderNames = [
      # Name, default, min, max
      ("Num Triangles", 600.0, 1.0, 10_000.0),
      ("View Radius", 150.0, 0.0, 600.0),
      ("Evade Edges", 0.2, 100.0, 500.0),
      ("Min Speed", 250.0, 50.0, 500.0),
      ("Max Speed", 400.0, 50.0, 500.0),

      ("Separation", 50.0, 0.0, 100.0),
      ("Alignment", 22.0, 0.0, 100.0),
      ("Cohesion", 13.0, 0.0, 100.0),
  ]

let
  widgetWidth = (ScreenWidth.float - 2 * margin) / numWidgetsPerRow.float
  widgetHeight = 20.0

proc createDefaultSliderAt(
    pos: Vector2,
    name: string,
    defaultValue, minValue, maxValue: float): Widget =
  Widget(kind: Slider,
         pos: pos,
         size: Vector2(x: widgetWidth, y: widgetHeight),
         bgColor: bgColor,
         fillColor: fillColor,
         borderColor: borderColor,
         textColor: textColor,
         name: name,
         showName: showSliderName,
         showValue: showSliderValue,
         value: defaultValue,
         high: maxValue,
         low: minValue)

proc createDefaultTextAt(pos: Vector2, text: string): Widget =
  Widget(kind: Text,
         pos: pos,
         size: Vector2(x: widgetWidth, y: widgetHeight),
         text: text,
         bgColor: bgColor,
         textColor: textColor,
         borderColor: borderColor)

proc createWidgets(): seq[Widget] =
  for i, (name, defaultVal, minVal, maxVal) in sliderNames:
    let
      x = float(i mod numWidgetsPerRow) * widgetWidth + margin
      y = float(int(i / numWidgetsPerRow)) * (widgetHeight + margin) + margin
    result.add(createDefaultSliderAt(Vector2(x: x, y: y), name, defaultVal, minVal, maxVal))

proc setupMainUi*(): Ui =
  Ui(widgets: createWidgets())
  

