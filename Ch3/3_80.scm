(load "stream_lib.scm")
(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
      initial-value
      (let ((integrand (force delayed-integrand)))
        (add-streams (scale-stream integrand dt) int))))
    int)

;    |-------------[ 1/L ] <-------
;    |                            |
;    |            -->[integral]   |---> Vc
;    |            |     ^--Vc0
;    |            |
;    |            |-[scale: -1/C]<----|
;    |-|       diL                    |
;      |-> [Add] --------->[integral]-|---------> iL
;    |-|                     ^--iL0   |
;    |                                |
;    |--------------[scale: -R/L]<----|
