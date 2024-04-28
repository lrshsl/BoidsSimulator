import util
import ui/main_ui
import ui/widgets

import nimraylib_now

proc apply_rules*(boids: var seq[Triangle], ui: Ui, dt: float) =
  let
    minSpeed = ui.get(MinSpeed)
    maxSpeed = ui.get(MaxSpeed)
  for t in boids.mitems:
    for other in boids:
      if t == other: continue
      let
        d = distance(t.pos, other.pos)
        strength = 1.0 / d
      if d > ui.get(ViewRadius): continue

      # Cohesion
      t.vel += (other.pos - t.pos) * strength * ui.get(Cohesion) * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)

      # Separation
      t.vel += (t.pos - other.pos) * strength * ui.get(Separation) * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)

      # Alignment
      t.vel += (other.vel - t.vel) * strength * ui.get(Alignment) * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)
