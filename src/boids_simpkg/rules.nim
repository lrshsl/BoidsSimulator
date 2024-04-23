import util

import nimraylib_now

proc apply_rules*(boids: var seq[Triangle], dt: float) =
  for t in boids.mitems:
    for other in boids:
      if t == other: continue
      let
        d = distance(t.pos, other.pos)
        strength = 1.0 / d
      if d > viewRadius: continue

      # Cohesion
      t.vel += (other.pos - t.pos) * strength * cohesionFactor * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)

      # Separation
      t.vel += (t.pos - other.pos) * strength * separateFactor * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)

      # Alignment
      t.vel += (other.vel - t.vel) * strength * alignFactor * dt
      t.vel = t.vel.clampValue(minSpeed, maxSpeed)
