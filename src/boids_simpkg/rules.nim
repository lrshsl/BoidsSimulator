import util
import parameters

import nimraylib_now

proc apply_rules*(boids: var seq[Triangle], ui: Ui, dt: float) =
  let
    minSpeed = getMinSpeed(ui)
    maxSpeed = getMaxSpeed(ui)
  for t in boids.mitems:
    for other in boids:
      if t == other: continue
      let
        d = distance(t.pos, other.pos)
        strength = 1.0 / d
      if d > getViewRadius(ui): continue

      # Cohesion
      t.vel += (other.pos - t.pos) * strength * getCohesionFactor(ui) * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)

      # Separation
      t.vel += (t.pos - other.pos) * strength * getSeparateFactor(ui) * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)

      # Alignment
      t.vel += (other.vel - t.vel) * strength * getAlignFactor(ui) * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)
