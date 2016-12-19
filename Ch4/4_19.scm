; Looking at this:
; a = 1
; f(x) = (b = 1 + x), (a = 5), (a + b) = (1 + 5 + x)
; f(10) = (b = 1 + 10 = 11) (a = 5) (a + b) = 1 + 5 + 11 = 16

; it seems natural that in a procedural language ben's point should hold

; in _scheme_ though, due to mutual recursion alyssa is probably right. As noted
; in the text, it is most definitely easier to emit a simultaneous definition error...
