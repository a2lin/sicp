; so this works because the call graph for magnitude looks like this:
; magnitude
; apply-generic magnitude < -complex
; this dispatches to the 'magnitude 'complex data-type, stripping the 'complex tag.
; which then dispatches to the 'magnitude 'rectangular/'polar data type, stripping
; the type tag along the way.

; apply-generic is invoked twice. once for 'magnitude 'complex, 
; and then again for 'magnitude 'rectangular.
