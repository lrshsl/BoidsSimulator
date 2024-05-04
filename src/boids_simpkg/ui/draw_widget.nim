from types import Ui, Widget, WidgetKind
import ../util
import ../constants

import nimraylib_now

import math

# Draw the widget, whatever it is
proc draw*(ui: Ui, wg: Widget) =
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
  of Text, Button, ToggleButton:
    let
      text = if wg.kind == Button or wg.kind == ToggleButton:
        wg.buttonText.cstring
      else:
        wg.text.cstring

      # Measure the text
      textWidth = measureText(text, fontSize)
      (_, textHeight) = measureTextEx(getFontDefault(), text, fontSize.cfloat, 0).tuple

    # Draw the text into the middle
    drawText(text,
             x + int(w / 2) - int(textWidth / 2),
             y + int(h / 2) - int(textHeight / 2),
             20, wg.textColor)

    # If clicked, dim the background
    if (wg.kind == Button or wg.kind == ToggleButton) and wg.isBeingClicked:
      drawRectangle(x, y, w, h, wg.bgColor.withAlpha(127))

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
