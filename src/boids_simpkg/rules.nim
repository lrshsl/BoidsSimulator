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

    var
      inView = 0

      avgPos = Vector2()
      avgVel = Vector2()
      separationForce = Vector2()

    for other in boids:

      # Don't include itself
      if t == other: continue

      # Only then calculate the distance
      let
        v = other.pos - t.pos
        d = v.length

      # TODO: restrict view by an angle
      if d < ui.get(ViewRadius):
        inView += 1

        # Cohesion
        avgPos += v.normalize

        # Alignment
        avgVel += other.vel - t.vel

      if d < ui.get(ProtectedZone):

        # Separation
        separationForce += -v.normalize * ui.get(Separation) * dt
    
    var
      cohesionForce = avgPos * ui.get(Cohesion)
      alignmentForce = avgVel.scale(1.0 / inView.float) * ui.get(Alignment)

    separationForce *= ui.get(Separation)

    t.vel += (cohesionForce + alignmentForce + separationForce) * dt
    t.vel = t.vel.clampValue(minSpeed, maxSpeed)





