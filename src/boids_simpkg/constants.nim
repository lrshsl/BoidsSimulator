import nimraylib_now

const
  # Directional Vectors according to the coordinate system of the screen
  # x: right, y: down
  Up* = Vector2(x: 0, y: -1)
  Down* = Vector2(x: 0, y: 1)
  Right* = Vector2(x: 1, y: 0)
  Left* = Vector2(x: -1, y: 0)

  # Margin from the edge of the screen
  margin* = 20.0

  # Rendering settings
  triangleSize* = Vector2(x: 12, y: 25) # width, height

var
  # Screen size (default)
  (screenWidth*, screenHeight*) = (1800, 900)


### Information for the ui elements ###
type
  # Enums over the available Sliders
  TopRow* {.pure.} = enum
    Separation
    Alignment
    Cohesion
    ProtectedZone

  BottomRow* {.pure.} = enum
    NumTriangles = TopRow.high.ord + 1
    ViewRadius
    EvadeEdges
    MinSpeed
    MaxSpeed

  # Values for the sliders
  SliderInfo* = tuple[name: string, start, min, max: float]


const
  # Font size
  fontSize* = 18 ## Default font size in pixels

  # Colors
  textColor* = White ## Text color of all text
  bgColor* = Black ## Background color of all widgets
  fillColor* = Green ## Fill color. Used in sliders only for the movable part
  borderColor* = White ## Border color of widgets with borders

  # Clickless ui
  clicklessUiDefault* = true ## Toggle clickless UI. If on, sliders will be updated on hover

  # Show the name and value of the slider in the format `name: value`
  showSliderNameDefault* = true ## Show the name of the sliders ("cohesion", "num triangles", etc.)
  showSliderValueDefault* = true ## Show the value of the sliders. If both name and value are on, it will be shown in the format `name: value`

  # Enable debug mode
  debugModeDefault* = false ## Toggle debug mode. Draws the view radius, protected zone and center of mass of one bird and enables the visualization of other debug values

  # Picture mode
  pictureModeDefault* = false ## Toggle picture mode alias "Hide All". Hides all widgets. Can be reactivated on mouse click

  # Sliders
  top_row*: array[TopRow, SliderInfo] = [
      ## The sliders that are placed in the top row (Separation, Alignment, Cohesion, Protected Zone)
      # Slider:      [     name,        start,  min,  max     ]
      Separation:    ("Separation",     0.5,    0.0,  1.0     ),
      Alignment:     ("Alignment",      0.5,    0.0,  1.0     ),
      Cohesion:      ("Cohesion",       0.5,    0.0,  1.0     ),
      ProtectedZone: ("Protected Zone", 70.0,   0.0,  200.0   ),
  ]
  bottom_row*: array[BottomRow, SliderInfo] = [
      ## The sliders that are placed in the bottom row (Num Triangles, View Radius, Evade Edges, Min Speed, Max Speed)
      # Slider:      [     name,        start,  min,  max     ]
      NumTriangles:  ("Num Triangles",  600.0,  1.0,  2_000.0 ),
      ViewRadius:    ("View Radius",    150.0,  0.0,  600.0   ),
      EvadeEdges:    ("Evade Edges",    0.2,    0.0,  1.0     ),
      MinSpeed:      ("Min Speed",      250.0,  50.0, 1000.0  ),
      MaxSpeed:      ("Max Speed",      400.0,  50.0, 1000.0  ),
  ]

# The following values can't be evaluated at compile time bc of the `screenWidth` and `screenHeight` variables

proc widgetHeight*(): float =
  ## Current widget width
  22.0

proc widgetWidth*(): float =
  ## Current widget height (relative to screen width)
  (screenWidth.float - 2 * margin) / float(top_row.len + 1)


#----- Settings popup -----#

proc defaultButtonSize*():
  Vector2 = Vector2(x: 150.0, y: 30.0)

# Settings button
proc settingsButtonSize*(): Vector2 =
  defaultButtonSize()

proc settingsButtonPos*(): Vector2 =
  Vector2(x: screenWidth.float - settingsButtonSize().x - margin,
          y: margin)

# Settings popup
proc popupSize*(): Vector2 =
  Vector2(x: defaultButtonSize().x + margin * 2,
          y: screenHeight.float * 0.8)

proc popupTopLeft*(): Vector2 =
  Vector2(x: screenWidth.float - popupSize().x - margin,
          y: margin * 2 + widgetHeight())


