### Remember what we did in `rember` and `insertL` at the end of chapter 5?
We replaced the use of `eq?` for `equal?`

### Can you write a function `rember-f` that would use either eq? or equal?
No, because we have not yet told you how.

### How can you make `rember` remove the first `a` from (b c a)
`rember a '(b c a)`

### How can you make rember-f use equal? instead of eq?
By passing `equal?` to `rember-f` as an argument

### What is `(rember-f test? a l)` where `test?` is `=` `a` is 5 and `l` is (6 2 5 3)
`(6 2 3)`
