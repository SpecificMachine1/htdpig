;;;graphics-stub.scm
;;; script which provides access to graphics libraries and some convienence
;;; functions for using Chickadee from the repl
;;; use via: chickadee --repl grapics-stub.scm
(import (chickadee math vector)
        (chickadee graphics path)
        (chickadee graphics sprite)
        (chickadee graphics viewport)
        (srfi srfi-9))

#|A GraphicRecord is an abstraction for the record types used by Chickadee
   -painter
   -texture
to write a set of common functions used in htdp/image and htdp/animation
|#

;;(get-width graphic-record) -> Num
(define (get-width gr)
  (cond
    ((painter? gr) (rect-width (painter-bounding-box gr)))
    ((texture? gr) (texture-width gr))
    (else (error "don't know how to find width" gr))))

;;(get-height graphic-record) -> Num
(define (get-height gr)
  (cond
    ((painter? gr) (rect-height (painter-bounding-box gr)))
    ((texture? gr) (texture-height gr))
    (else (error "don't know how to find height" gr))))

#|
the pngs can be used by

;; Texture
(define sprite (load-image "chickadee.png"))

;; ChickadeeIO
;;Writing this in the repl causes the IO, not sure how this works
(define (draw alpha)
  (draw-sprite sprite (ve2 256.0 176.0)))

;;loading the rocket
(define rocket (load-image "rocket.png"))

(* (get-width rocket) (get-height rocket))
; => 1176

;;(circle 10 "solid" "red")
;;(rectangle 30 20 "outline" blue")
;;  in htdp will output cirles and images to the output area. With Chickdee, I
;;  think you have to include a location so everything is more like (place-imag
;;  e... (empty-scene ...))
|#

;;<painter> for a solid red circle of radius 10 centered at (100,100)  
(define red-circle
  (with-style ((fill-color red))
              (fill (circle (vec2 100.0 100.0) 10))))

;;<painter> for a blue outline 20x30 rectangle centered at (100,100)
(define blue-out-rect
  (with-style ((stroke-color blue)
                (stroke-width 1.0))
     (stroke (rectangle (vec2 85.0 90.0) 30.0 20.0))))

;;<painter> for a solid blue 20x30 rectangle centered at (100,100)
(define blue-fill-rect
  (with-style ((fill-color blue))
     (fill (rectangle (vec2 85.0 90.0) 30.0 20.0))))

;;<painter> that shows red circle on top of solid blue rectangle
(define circle-on-rectangle (superimpose blue-fill-rect red-circle))

#|
to display these types in the repl
(define canvas (make-canvas <painter>))
(define (draw alpha) (draw-canvas canvas))
|#

;;;;;;;;;;;;;;;;;;;;;;;;;Beginning of Animation Section;;;;;;;;;;;;;;;;;;;;;;;

;;Get info about window to use for placing rocket
(define (height) (viewport-height (current-viewport)))
(define (width) (viewport-width (current-viewport)))
;; this does not work, have to hard code info in
(define WIN-HEIGHT 480.0)
(define WIN-WIDTH 640.0)

(define birb (load-image "chickadee.png"))

(define posn (vec2 (/ (- WIN-WIDTH (get-width birb)) 2.0)
                   (- WIN-HEIGHT (get-height birb))))

(define (draw alpha)
  (draw-sprite birb posn))

(define (update dt)
  (if (> (vec2-y posn) 0)
    (vec2-sub! posn (vec2 0.0 1.0))))
