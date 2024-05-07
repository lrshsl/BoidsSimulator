import ui/main_ui
from ui/types import Ui
import util
import constants

import nimraylib_now

proc avoidEdges*(triangles: var seq[Triangle], ui: Ui) =
  let screen = Rectangle(x: 0.0, y: 0.0,
                       width: screenWidth.float,
                       height: screenHeight.float)
  for t in triangles.mitems:
    let
      vr = ui.get(ViewRadius)
      f = ui.get(EvadeEdges)
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

proc apply_rules*(boids: var seq[Triangle], ui: Ui, dt: float) =
  let
    minSpeed = ui.get(MinSpeed)
    maxSpeed = ui.get(MaxSpeed)

  for t in boids.mitems:

    for other in boids:

      # Don't include itself
      if t == other: continue

      # Only then calculate the distance
      let
        d = distance(t.pos, other.pos)

        # TODO: Use fast inverse sqrt?
        strength = 1.0 / d

      # Only look at the boids within the view radius
      # TODO: restrict view by an angle
      if d < ui.get(ViewRadius):

        # Cohesion
        t.vel += (other.pos - t.pos) * strength * ui.get(Cohesion) * dt
        t.vel = t.vel.clampValue(minSpeed, maxSpeed)

        # Alignment
        t.vel += (other.vel - t.vel) * strength * ui.get(Alignment) * dt
        t.vel = t.vel.clampValue(minSpeed, maxSpeed)

      if d < ui.get(ProtectedZone):
        # Separation
        t.vel += (t.pos - other.pos) * strength * ui.get(Separation) * dt
        t.vel = t.vel.clampValue(minSpeed, maxSpeed)
