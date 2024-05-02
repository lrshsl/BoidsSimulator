import ../util
import ../constants

import nimraylib_now

import math

type
  # Ui holds all the widgets and functionality for all of them
  Ui* = ref object
    widgets*: seq[Widget]

  # Possible types of single widgets
  WidgetKind* = enum
    Text,
    Button,
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
    of Text, Button, TextField:
      text*: string

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


# Draw the widget, whatever it is
proc draw*(wg: Widget) =
  let
    (x, y) = wg.pos.ints
    (w, h) = wg.size.ints

  # Draw the background
  drawRectangle(x, y, w, h, wg.bgColor)

  # Draw the border
  drawRectangleLines(x, y, w, h, wg.borderColor)

  # Additional things may be drawn depending on the kind
  case wg.kind

  # Text and Buttons only
  of Text, Button:
    drawText(cstring(wg.text), x, y, 20, wg.textColor)

  # Text field isn't yet implemented
  of TextField:
    raise newException(Exception, "TODO: TextField")

  # Slider only
  of Slider:
    let
      m = 5

      # Choose what text needs to be drawn
      sliderText = if wg.showValue and wg.showName:
        wg.name & ": " & ($round(wg.value, 3) & ' ')[0..3]
      elif wg.showValue:
        ($round(wg.value, 3) & ' ')[0..3]
      elif wg.showName:
        wg.name
      else:
        ""

      # Measure the text
      textWidth = measureText(cstring(sliderText), fontSize)
      (_, textHeight) = measureTextEx(getFontDefault(), cstring(sliderText), fontSize.cfloat, 0).tuple

    # Draw the slider value
    drawRectangle(x + m, y + m,
                  int((wg.value - wg.low) / (wg.high - wg.low) * float(w - 2 * m)), h - 2 * m,
                  wg.fillColor)

    # Draw the text into the middle of the slider
    drawText(cstring(sliderText),
             x + int(w / 2) - int(textWidth / 2),
             y + int(h / 2) - int(textHeight / 2),
             fontSize, wg.textColor)

proc update*(wg: var Widget) =
  let
    x = getMouseX().float
    y = getMouseY().float
  case wg.kind
  of Text, Button, TextField:
    discard
  of Slider:
    if x > wg.pos.x and x < wg.pos.x + wg.size.x and
        y > wg.pos.y and y < wg.pos.y + wg.size.y:
      wg.value = (x - wg.pos.x) / wg.size.x * (wg.high - wg.low) + wg.low

proc `draw`*(ui: Ui) =
  for wg in ui.widgets:
    wg.draw()

proc `update`*(ui: var Ui) =
  for wg in ui.widgets.mitems:
    wg.update()

