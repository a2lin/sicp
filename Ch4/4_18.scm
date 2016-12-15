; this is going to cause problems because a and b 
; depend on each other, and the let statements are 
; themselves transformed.

; if scanned out in the way the text showed,
; a+b will transform correctly w.r.t each other.

; okay let's do this the right way (e.g. actually try to do it right):
; Scanning out the first:
; (define (solve f y0 dt)
;   (lambda <vars>
;     (let ((y '*unassigned*) (dy '*unassigned*))
;       (let ((a (integral (delay dy) y0 dt))
;             (b (stream-map f y)))
;             (set! y a)
;             (set! dy b))
;        y
;     )
;   )
; )
; 
; second transformation:
; ((lambda y dy)
;    (lambda (a b)
;       set! y a
;       set! dy b
;    integral (delay dy) y0 dt
;    stream-map f y
;   y
; 'unassigned
; 'unassigned
; and therefore we are going to have a problem.

; in the normal version,
; it expands out to look like
;(define (solve f y0 dt)
;  ((lambda <vars>
;    (let ((y '*unassigned*)
;          (dy '*unassigned*))
;      (set! y (integral (delay dy) y0 dt))
;      (set! dy ((stream-map f y)))
;      y))
;     '*unassigned*
;     '*unassigned*

; in this event this should be fine as both names available and set.
