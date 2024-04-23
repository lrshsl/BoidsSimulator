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

proc rule_separate*(boids: var seq[Triangle], dt: float) =
  for t in boids.mitems:
    for other in boids:
      if t == other:
        continue
      let
        d = distance(t.pos, other.pos)
        strength = 1.0 / d
      if d < viewRadius:
        t.vel += (t.pos - other.pos) * strength * separateFactor * dt
        t.vel = t.vel.clampValue(minSpeed, maxSpeed)

proc rule_align*(boids: var seq[Triangle], dt: float) =
  for t in boids.mitems:
    for other in boids:
      if t == other:
        continue
      let
        d = distance(t.pos, other.pos)
        strength = 1.0 / d
      if d < viewRadius:
        t.vel += (other.heading - t.heading) * strength * alignFactor * dt
        t.vel = t.vel.clampValue(minSpeed, maxSpeed)
