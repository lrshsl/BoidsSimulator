import util
import constants

import nimraylib_now

import math

proc draw*(wg: Widget) =
  let
    (x, y) = wg.pos.ints
    (w, h) = wg.size.ints
  drawRectangle(x, y, w, h, wg.bgColor)
  drawRectangleLines(x, y, w, h, wg.borderColor)
  case wg.kind
  of Text, Button:
    drawText(cstring(wg.text), x, y, 20, wg.textColor)
  of TextField:
    raise newException(Exception, "TODO: TextField")
  of Slider:
    let
      m = 5
      sliderText = if wg.showValue:
        wg.name & ": " & ($round(wg.value, 3) & ' ')[0..3]
      else:
        ""
      textWidth = measureText(cstring(sliderText), fontSize)
      (_, textHeight) = measureTextEx(getFontDefault(), cstring(sliderText), fontSize.cfloat, 0).tuple
    drawRectangle(x + m, y + m,
                  int((wg.value - wg.low) / (wg.high - wg.low) * float(w - 2 * m)), h - 2 * m,
                  wg.fillColor)
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

