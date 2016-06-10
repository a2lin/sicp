; z1 [][]
; x [][] -> [][/]
;   a        b

;-----------

; z1 [][]
; x [][] -> [][/]
;   wow      b

; so both z1 car and cdr are 'wow b'

; z2 (x) [a][->][b][/]
;        [a][->][b][/]

;----------

; z2 (x) [wow][->][b][/]
;        [a][->][b][/]
; we only modify first pair here.
