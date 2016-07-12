; let's try a scenario as follows:
; if balance is unserialized you could receive a balance mid-withdraw or mid-deposit.
; protected guarantees that withdraw and deposit are serializable with relation to
; each other. however, there is no such restriction put on balance
; until this solution, and therefore an individual checking balance
; can get any kind of state (e.g. requesting balance after withdraw may still return
; the original balance).
