import util

import nimraylib_now

func centerOfMass*(boids: seq[Triangle]): Vector2 =
  for t in boids:
    result += t.pos
  result *= 1.0 / boids.len.float

func rule_align*(boids: var seq[Triangle], dt: float) =
  for t in boids.mitems:
    t.targetHeading = headingTowards(t.pos, centerOfMass(boids))

proc rule_separate*(boids: var seq[Triangle], neighborDistance: float, dt: float) =
  for t in boids.mitems:
    for other in boids:
      if other == t:
        continue
      if distance(t.pos, other.pos) < neighborDistance:
        t.targetHeading += headingTowards(t.pos, other.pos)

proc rule_cohesion*(boids: var seq[Triangle], dt: float) = discard
