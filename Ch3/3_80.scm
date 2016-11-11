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

(define (RLC R L C Vc0 iL0 dt)
  (define iL (integral 
               (delay (add-streams 
                        (scale-stream Vc (/ 1 L)) 
                        (scale-stream iL (/ (* -1 R) L)))
                      )
               iL0 dt)
    )
  (define Vc (integral (delay (scale-stream iL (/ -1 C))) Vc0 dt))
  (define state (stream-map cons iL Vc))
  state
  )

(take (RLC 1000 1 0.001 100 1000 0.001) 7)
