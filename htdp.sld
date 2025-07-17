(define-library (htdp)
  (export sqr pi)
  (import (scheme base) (scheme inexact))
  (begin
    (define sqr square)
    (define pi (acos -1))
    ))
