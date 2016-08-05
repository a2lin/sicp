; when improving in the new way, we have to calculate sqrt-stream of x
; again, since a new copy of the sqrt-improve stream is passed to the 
; new sqrt-improve fn.
;
; In the old way, they all share the same sqrt-improve stream, and therefore
; the results are cached and do not need to be recalculated.
;
; > this would no longer apply if memo-proc was not used, as neither would be cached.
