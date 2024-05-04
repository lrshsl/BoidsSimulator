from nimraylib_now import Vector2, Color

type
  # Ui holds all the widgets and functionality for all of them
  Ui* = ref object
    widgets*: seq[Widget]
    showSettings*: bool

  # Possible types of single widgets
  WidgetKind* = enum
    Text,
    Button,
    ToggleButton,
    TextField,
    Slider

  # Data for a single widget
  Widget* = ref object

    # Position of top left corner
    pos*: Vector2
    # Size of the widget (no margin)
    size*: Vector2

    # Colors
    bgColor*, textColor*, borderColor*: Color

    # Some data depends on the type
    case kind*: WidgetKind

    # .. text only if one of {Text, Button, TextField}
    of Text, TextField:
      text*: string

    of Button, ToggleButton:
      buttonText*: string
      isBeingClicked*: bool = false

      # Callbacks
      onClick*: proc(ui: Ui)
      onRelease*: proc(ui: Ui)

    # Slider needs more data
    of Slider:

      # What value is displayed
      name*: string

      # Minimum, maximum, and current value
      high*, low*, value*: float

      # Flags
      showName*, showValue*: bool

      # Fill color is also specific to Slider
      fillColor*: Color


