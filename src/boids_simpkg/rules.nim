## This module defines the rules for the behaviour of the single boids.
##
## ### Cohesion
## Cohesion makes the boids wanting to move together, towards the center of mass of the boids in its field of view.
## Through cohesion, boids want to get closer together. This - with the help of the other rules - results in the typical flocking behaviour similar to birds and fish.
##
## ### Separation
## Separation is the opposite force to cohesion. It makes sure that the boids don't just fly into each other.
## This is accomplished by a contrary force which increases as two boids come closer to each other.
## It only activates if the boids enter each other's protected zone. The protected zone is a subzone of the field of view, in which the boids don't want other boids to be in.
##
## ### Alignment
## Alignment is the last essential force. It makes the boids want to move in the same direction as the other boids.
## This also activates for all the boids in the field of view.
##
## ### Avoid edges
## Since the simulated boids shouldn't fly off the edges of the screen, they have to avoid edges somehow.
## I first implemented this by a simple bouncing-off the edges, but since this happends very often, it resulted in very unnatural behaviour of the boids.
## Now a separate rule in the "AI" of the boids tries to steer away from the screen edges as soon as they enter the field of view.

import ui/main_ui
from ui/types import Ui
import util
import constants

import nimraylib_now

proc apply_rules*(boids: var seq[Triangle], ui: Ui, dt: float) =
  ## This function applies all rules to each boid in `boids`.
  ## It has been combined into a single function in order to increase performance by only looping over the boids once.

  let
    minSpeed = ui.get(MinSpeed)
    maxSpeed = ui.get(MaxSpeed)
    vr = ui.get(ViewRadius)
    f = ui.get(EvadeEdges)
    screen = Rectangle(x: 0.0, y: 0.0,
                       width: screenWidth.float,
                       height: screenHeight.float)

  for t in boids.mitems:

    var
      inView = 0

      avgPos = Vector2()
      avgVel = Vector2()
      separationForce = Vector2()

    for other in boids:

      # Don't include itself
      if t == other: continue

      # Calculate the distance
      let
        v = other.pos - t.pos
        d = v.length

      if d < vr:
        inView += 1

        # Cohesion
        avgPos += v.normalize

        # Alignment
        avgVel += other.vel - t.vel

      if d < ui.get(ProtectedZone):

        # Separation
        separationForce += -v.normalize * dt

    #----- Avoid edges -----#
    let
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
    
    var
      cohesionForce = avgPos * ui.get(Cohesion) / 100 # Scale by 100 to make it easier to adjust
      alignmentForce = avgVel.scale(1.0 / inView.float) * ui.get(Alignment) * 2

    separationForce *= ui.get(Separation) * 1000

    t.vel += (cohesionForce + alignmentForce + separationForce) * dt
    t.vel = t.vel.clampValue(minSpeed, maxSpeed)





