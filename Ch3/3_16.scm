; [][->][][->][][/] = 3 (three normal pairs)
; [a][->][b~c][->][c][/] = 4 (first one is counted as 1, then second both car and cdr point to the last index, so 1 + 1 + 2 = 4
; [a~b][->][b~c][->][c][/] = 7 (first one splits into 2 'b segments, which split each into 2 'c segments. so 4 + 2 + 1 = 7.
; [a~b][->][b~a][->][c][/] = infinite (a loop = infinite)
