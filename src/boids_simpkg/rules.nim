import util

import nimraylib_now

func centerOfMass*(boids: seq[Triangle]): Vector2 =
  for t in boids:
    result += t.pos
  result *= 1.0 / boids.len.float

proc rule_cohesion*(boids: var seq[Triangle], dt: float) =
  for t in boids.mitems:
    t.vel += (centerOfMass(boids) - t.pos) * cohesionFactor * dt
    t.vel = t.vel.clampValue(minSpeed, maxSpeed)

proc rule_separate*(boids: var seq[Triangle], neighborDistance: float, dt: float) =
  for t in boids.mitems:
    for other in boids:
      if t == other:
        continue
      let d = distance(t.pos, other.pos)
      if d < viewRadius:
        t.vel += (other.pos - t.pos) / d * separateFactor * dt

proc rule_align*(boids: var seq[Triangle], dt: float) = discard
