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

### What is `(rember-f test? a l)` where `test?` is `eq?` `a` is jelly and `l` is (jelly beans are good)
`(beans are good)`

### What is `(rember-f test? a l)` where `test?` is `equal?`
### `a` is (pop corn) and `l` is (lemonade (pop corn) and (cake))
`(lemonade and (cake))`

###  Try to write rember-f
```
(define rember-f
  (lambda (test? a l)
    (cond
      ((null? l) '())
      ((test? (car l) a) (cdr l))
      (else
        (cons (car l) (rember-f test? a (cdr l)))
      )
    )
  )
)
```

### How does `(rember-f test? a l)` act where `test?` is `eq?`
Acts like rember

### And what about `(rember-f test? a l)` where `test?` is `equal?`
Acts like rember with `eq?` replaced by `equal?`

### What kind of values can functions return?
Booleans, lists, atoms and functions

### Can you say what (lambda (a l) ... ) is?
It's a function of two arguments, `a` and `l`

### Now what is `(lambda (a) (lambda (x) (eq? x a)))`
It's a function with argument `a` that returns another function with argument `x` that compare `a` to `x` using `eq?`

### Is this called "Curry-ing?"
Thank you, Moses Schonfinkel (1889 - 1942).

### It is not called "Schonfinkel-ing."
Thank you, Haskell B. Curry (1900 - 1982).

### Using (define ... ) give the preceding function a name.
```
(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a)
    )
  )
)
```

### What is `(eq?-c k)` where `k` is salad
`(lambda (x) (eq? x salad))`

### So let's give it a name using (define ... )
```
(define eq?-salad
  (eq?-c k)
)
```
### where `k` is salad

### What is `(eq?-salad y)` where `y` is salad
True

### And what is `(eq?-salad y)` where `y` is tuna
False

### Do we need to give a name to `eq?-salad`
No, we may just as well ask `((eq?-c x) y)` where `x` is salad and `y` is tuna.

### Now rewrite `rember-f` as a function of one argument `test?`
### that returns an argument like `rember` with `eq?` replaced by `test?`
```
(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? (car l)) (cdr l))
        (else
          (cons (car l) ...)
        )
      )
    )
  )
)
```

### Describe in your own words the result of `(rember-f test?)` where `test?` is `eq?`
The result of `(rember-f test?)` is a function that acts like `rember` using `eq?` as the comparator function

### Give a name to the function returned by `(rember-f test?)` where `test?` is `eq?`
`(define rember-eq? (rember-f test?))` where `test?` is `eq?`

### What is (rember-eq? a l) where `a` is tuna and `l` is (tuna salad is good)
`(salad is good)`

### Did we need to give the name `rember-eq?` to the function `(rember-f test?)` where `test?` is `eq?`
No, we could just use `((rember-f eq?) a l)`

### Now, complete the line (cons (car l) ...) in `rember-f` so that `rember-f` works.
```
(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else
          (cons
            (car l)
            ((rember-f test?) a (cdr l))
          ))))))
```

### What is `((rember-f eq?) a l)` where `a` is tuna and `l` is (shrimp salad and tuna salad)
`(shrimp salad and salad)`

###  What is `((rember-f eq?) a l)` where `a` is eq? and `l` is (equal? eq? eqan? eqlist? eqpair?)
`(equal? eqan? eqlist? eqpair?)`

### And now transform `insertL` to `insertL-f` the same way we have transformed `rember` into `rember-f`
```
(define insertL-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) '())
        ((test? old (car l))
          (cons new (cons old (cdr l)))
        )
        (else
          (cons
            (car l)
            ((insertL-f test?) new old (cdr l))
          )
        )
      )
    )
  )
)
```

### And, just for the exercise, do it to `insertR`
```
(define insertR-f
  (lambda (test?)
    (lambda (new old l)
      (cond
        ((null? l) '())
        ((test? old (car l))
          (cons old (cons new (cdr l)))
        )
        (else
          (cons
            (car l)
            ((insertR-f test?) new old (cdr l))
          )
        )
      )
    )
  )
)
```

### Are `insertR` and `insertL` similar?
Yes, its just the order of `new` and `old` thats different

### Can you write a function `insert-g` that would insert either at the left or at the right?
```
(define insert-g
  (lambda (test?)
    (lambda (g new old l)
      (cond
        ((null? l) '())
        ((test? (car l) old)
          (g new old (cdr l))
        )
        (else
          (cons
            (car l)
            ((insert-g test?) g new old (cdr l))
          )
        )
      )
    )
  )
)
```

### Which pieces differ?
The second lines.
InsertR is:
```
((test? old (car l))
  (cons old (cons new (cdr l)))
)
```
InsertL is:
```
((test? old (car l))
  (cons new (cons old (cdr l)))
)
```

### Put the difference in words!
The two functions `cons` `new` and `old` in a different order onto the `cdr` of `l`

### So how can we get rid of the difference?
By defining the specific `cons` for each function.

### Define a function seqL that
### 1. takes three arguments
### 2. conses the first argument onto the result of consing the second argument onto the third argument.
```
(define seqL
  (lambda (new old l)
    (cons new (cons old l))
  )
)
```

### Write seqR
```
(define seqR
  (lambda (new old l)
    (cons old (cons new l))
  )
)
```

### Do you know why we wrote these functions?
Because they express what the two differing lines in `insertL` and `insertR` express.

### Try to write the function `insert-g` of one argument `seq` which returns `insertL` where `seq` is `seqL` and
### which returns `insertR` where `seq` is `seqR`
```
(define insert-g
  (lambda (seq)
    (lambda (new old l)
      (cond
        ((null? l) '())
        ((eq? (car l) old)
          (seq new old (cdr l)))
        (else
          (cons
            (car l)
            ((insert-g seq) new old (cdr l))
          )
        )
      )
    )
  )
)
```

### Now define `insertL` with `insert-g`
```
(define insertL (insert-g seqL))
```

### And `insertR`
```
(define insertR (insert-g seqR))
```

### Is there something unusual about these two definitions?
Yes. Earlier we would probably have written `(define insertL (insert-g seq))` where `seq` is `seqL` and
`(define insertR (insert-g seq))` where `seq` is `seqR`.
But, using "where" is unnecessary when you pass functions as arguments.

### Is it necessary to give names to seqL and seqR
No, we could pass their definitions instead

### Define insertL again with `insert-g`.
### Do not pass in `seqL` this time.
```
(define insertL
  (insert-g
    (lambda (new old l)
      (cons new (cons old l))
    )
  )
)
```

### Is this better?
Yes, because you do not need to remember as many names

### Do you remember the definition of `subst`
```
(define subst
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((eq? (car l) old)
        (cons new (cdr l)))
      (else
        (cons
          (car l)
          (subst new old (cdr l)))
      )
    )
  )
)
```

### Does this look familiar?
Yes, it's equal to `insertL` and `insertR` except for the second lines

### Define a function like `seqL` or `seqR` for `subst`
```
(define seqS
  (lambda (new old l)
    (cons new l)
  )
)
```

### And now define subst using insert-g
```
(define subst (insert-g seqS))
```

###  And what do you think `yyy` is
```
(define yyy
  (lambda (a l)
    ((insert-g seqrem) #f a l)))
```
### where
```
(define seqrem
  (lambda (new old l) l))
```
It's the function `rember` where `#f` acts as a dummy value for `seqrem`

### Do you remember `value` from chapter 6?
```
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp) '+)
        (+ (value (1st-sub-exp nexp)) ((value 2nd-sub-exp nexp)))
      )
      ((eq? (operator nexp) 'x)
        (x (value (1st-sub-exp nexp)) ((value 2nd-sub-exp nexp)))
      )
      (else
        (expt (value (1st-sub-exp nexp)) ((value 2nd-sub-exp nexp)))
      )
    )
  )
)
```

### Do you see the similarities?
Yes, the `operator` maps into a function.
The last three answers are the same except for the `+`, `x`, and `expt`.

### Can you write the function `atom-to-function` which:
1. Takes one argument `a` and
2. returns the function `+`
    if `(eq? a '+)`
   returns the function `x`
    if `(eq? x 'x)` and
   returns the function `expt` otherwise?

```
(define atom-to-function
  (lambda (atom)
    (cond
      ((eq? atom '+) +)
      ((eq? atom 'x) x)
      (else expt)
    )
  )
)
```

###  What is `(atom-to-function (operator nexp))` where `nexp` is (+ 5 3)
The function `+`

### Can you use `atom-to-function` to rewrite `value` with only two cond-lines?
```
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
        ((atom-to-function (operator nexp))
          (value (1st-sub-expression nexp))
          (value (2nd-sub-expression next)))
      )
    )
  )
)
```

### Is this quite a bit shorter than the first version?
Yes, quite a bit
