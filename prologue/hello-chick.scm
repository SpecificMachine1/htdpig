;;;hello-chick.scm
;;; hello world program for Chickadee game engine
;;; called like:
;;; chickadee play hello-chick.scm

(define (draw alpha)
  (draw-text "Hello, world!" (vec2 260.0 240.0)))
