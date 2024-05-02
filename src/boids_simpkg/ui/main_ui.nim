import widgets
import ../constants

import nimraylib_now

import std/sugar

type
  # Enum over the available Sliders
  Sliders* {.pure.} = enum
    NumTriangles
    ViewRadius
    EvadeEdges
    MinSpeed
    MaxSpeed
    Separation
    Alignment
    Cohesion

  # Values for the sliders
  SliderInfo = tuple[name: string, start, min, max: float]

# Getter function to retrieve the value of a slider
proc get*(ui: Ui, s: Sliders): float =
  ui.widgets[s.int].value

# Information for the sliders
const
  # Put 5 sliders on a row --> Leaves space for additional ui elements
  numWidgetsPerRow = 5

  # Margin from the edge of the screen
  margin = 20.0
  firstRowStart = Vector2(x: margin, y: margin)

  # Colors
  bgColor = Black
  textColor = White
  fillColor = Green
  borderColor = White

  # Show the name and value of the slider in the format `name: value`
  showSliderName = true
  showSliderValue = true

  # Values for the sliders
  sliderInfo: array[Sliders, SliderInfo] = [

      # Slider:     [name,            start,  min,  max]
      NumTriangles: ("Num Triangles", 600.0,  1.0,  1_000.0 ),
      ViewRadius:   ("View Radius",   150.0,  0.0,  600.0   ),
      EvadeEdges:   ("Evade Edges",   0.2,    0.0,  1.0     ),
      MinSpeed:     ("Min Speed",     250.0,  50.0, 1000.0  ),
      MaxSpeed:     ("Max Speed",     400.0,  50.0, 1000.0  ),
      
      # Second row
      Separation:   ("Separation",    50.0,   0.0,  100.0   ),
      Alignment:    ("Alignment",     22.0,   0.0,  100.0   ),
      Cohesion:     ("Cohesion",      13.0,   0.0,  100.0   ),
  ]

# Can only be runtime-evaluated because it needs to know the screen/window size
let
  widgetWidth = (ScreenWidth.float - 2 * margin) / numWidgetsPerRow.float
  widgetHeight = 22.0

# Helper function to create a slider with the metadata from the consts above
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

# Create all the widgets with the inforamtion from `sliderInfo` above
proc createWidgets(): seq[Widget] =
  for i, (name, defaultVal, minVal, maxVal) in sliderInfo:
    let
      x = float(i.int mod numWidgetsPerRow) * widgetWidth + margin
      y = float(int(i.int / numWidgetsPerRow)) * (widgetHeight + margin) + margin
    result.add(createDefaultSliderAt(Vector2(x: x, y: y), name, defaultVal, minVal, maxVal))

# Export a simple, easy to use function
proc setupMainUi*(): Ui =
  Ui(widgets: createWidgets())
  

