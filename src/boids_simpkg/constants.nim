import nimraylib_now

const
  # Directional Vectors according to the coordinate system of the screen
  # x: right, y: down
  Up* = Vector2(x: 0, y: -1)
  Down* = Vector2(x: 0, y: 1)
  Right* = Vector2(x: 1, y: 0)
  Left* = Vector2(x: -1, y: 0)

  # Screen size (default)
  (ScreenWidth*, ScreenHeight*) = (1800, 900)

  # Margin from the edge of the screen
  margin* = 20.0

  # Rendering settings
  triangleSize* = Vector2(x: 12, y: 25) # width, height


### Information for the ui elements ###
type
  # Enums over the available Sliders
  TopRow* {.pure.} = enum
    Separation
    Alignment
    Cohesion

  BottomRow* {.pure.} = enum
    NumTriangles = ord(TopRow.high) + 1
    ViewRadius
    EvadeEdges
    MinSpeed
    MaxSpeed

  # Values for the sliders
  SliderInfo* = tuple[name: string, start, min, max: float]


const
  # Put 5 sliders on a row
  fontSize* = 18
  numWidgetsPerRow* = 5

  # Colors
  bgColor* = Black
  textColor* = White
  fillColor* = Green
  borderColor* = White

  # Clickless ui -> update sliders on hover instead of click
  clicklessUiDefault* = true

  # Show the name and value of the slider in the format `name: value`
  showSliderNameDefault* = true
  showSliderValueDefault* = true

  # Enable debug mode
  debugModeDefault* = false

  # Sliders
  top_row*: array[TopRow, SliderInfo] = [
      # Slider:     [     name,       start,  min,  max     ]
      Separation:   ("Separation",    50.0,   0.0,  100.0   ),
      Alignment:    ("Alignment",     22.0,   0.0,  100.0   ),
      Cohesion:     ("Cohesion",      13.0,   0.0,  100.0   ),
  ]
  bottom_row*: array[BottomRow, SliderInfo] = [
      # Slider:     [     name,       start,  min,  max     ]
      NumTriangles: ("Num Triangles", 600.0,  1.0,  2_000.0 ),
      ViewRadius:   ("View Radius",   150.0,  0.0,  600.0   ),
      EvadeEdges:   ("Evade Edges",   0.2,    0.0,  1.0     ),
      MinSpeed:     ("Min Speed",     250.0,  50.0, 1000.0  ),
      MaxSpeed:     ("Max Speed",     400.0,  50.0, 1000.0  ),
  ]

  widgetWidth* = (ScreenWidth.float - 2 * margin) / numWidgetsPerRow.float
  widgetHeight* = 22.0

  # Settings popup
  defaultButtonSize* = Vector2(x: 150.0, y: 30.0)

  # Settings button
  settingsButtonSize* = defaultButtonSize
  settingsButtonPos* = Vector2(
      x: ScreenWidth.float - settingsButtonSize.x - margin,
      y: margin)

  # Settings popup
  popupSize* = Vector2(
      x: 400,
      y: ScreenHeight.float * 0.8)
  popupTopLeft* = Vector2(
      x: ScreenWidth.float - popupSize.x - margin,
      y: margin)


