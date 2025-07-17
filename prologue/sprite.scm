(import (chickadee graphics sprite))

(define sprite (load-image "chickadee.png"))

(define (draw alpha)
  (draw-sprite sprite (vec2 256.0 176.0)))
