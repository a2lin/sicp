; case 1
; lambda <vars>
;   (define u <e1>)
;   (define v <e2>)
;   <e3>

; case 2
; lambda <vars>
;   (let (u '*unassigned*)
;        (v '*unassigned*)
;     set! u <e1>
;     set! v <e2>
;     <e3>

; (extend-environment u <e1>
; (extend-environment v <e2>

; there is an extra frame in the transformed program because
; the extra 'let' is creating a new frame.

; one way to make this work without a new frame is to directly set! u and v as unassigned,
; and then reset them to <e1>, <e2> after.; e.g. transform to:

; case 3
; lambda <vars>
;   set! u '*unassigned*'
;   set! v '*unassigned*'
;   set! u <e1>
;   set! v <e2>
;   <e3>
