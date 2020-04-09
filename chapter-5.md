###  What is `(rember* a l)` where `a` is cup and `l` is ((coffee) cup ((tea) cup) (and (hick)) cup)
### "rember*" is pronounced "rember-star."
`((coffee) ((tea)) (and (hick)))`

### What is `(rember* a l)` where `a` is sauce and `l` is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
`(((tomato)) ((bean)) (and ((flying))))`

### Now write `rember*`
```
(define rember*
  (lambda (a l)
    (cond
      ((null? l) '())
      ((atom? (car l))
        (cond
          ((eq? (car l) a)
            (rember* a (cdr l)))
          (else
            (cons
              (car l)
              (rember* a (cdr l))
            )
          )
        )
      )
      (else
        (cons
          (rember* a (car l))
          (rember* a (cdr l))
        )
      )
    )
  )
)
```

### `(lat? l)` where `l` is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
False

###  Is `(car l)` an atom where `l` is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
False

### What is (insertR * new old l) where `new` is roast `old` is chuck and
### `l` is ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood)
```
((how much (wood)) could ((a (wood) chuck roast))
  (((chuck roast))) (if (a) ((wood chuck roast))) could chuck roast wood)
```

### Now write the function `insertR*` which inserts the atom `new` to the right of `old` regardless of where old occurs.
```
(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
        (cond
          ((eq? (car l) old)
            (cons
              old
              (cons new (insertR* new old (cdr l)))
            )
          )
          (else
            (cons (car l) (insertR* new old (cdr l)))
          )
        )
      )
      (else
        (cons
          (insertR* new old (car l))
          (insertR* new old (cdr l))
        )
      )
    )
  )
)
```

### How are `insertR*` and `rember*` similar?
Each function asks three questions.
They both recur with the `car`, whenever the `car` is a list, as well as with the `cdr`.

### How are `rember*` and `multirember` different?
`multirember` only works in a list of atoms

### How are all *-functions similar?
They all ask three questions, `(null? l)`, `(atom? (car l))`, and `else`.
And recur with the `car`, whenever the `car` is a list, as well as with the `cdr`.

### Why?
Because all *-functions work on lists that are either
* empty,
* an atom consed onto a list, or
* a list consed onto a list.

### `(occursomething a l)` where `a` is banana and `l` is
### ((banana) (split ((((banana ice))) (cream (banana)) sherbet)) (banana) (bread) (banana brandy))
5

### What is a better name for `occursomething`
occur*

### Write `occur*`
```
(define occur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
        (cond
          ((eq? a (car l))
            (add1 (occur* a (cdr l)))
          )
          (else
            (occur* a (cdr l))
          )
        )
      )
      (else
        (+ (occur* a (car l)) (occur* a (cdr l)))
      )
    )
  )
)
```

###  (subst* new old l) where `new` is orange `old` is banana and `l` is
### ((banana) (split ((((banana ice))) (cream (banana)) sherbet)) (banana) (bread) (banana brandy))
`((orange) (split ((((orange ice))) (cream (orange)) sherbet)) (orange) (bread) (orange brandy))`

### Write `subst*`
```
(define subst*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l)
        (cond
          ((eq? (car l) old)
            (cons new (subst* new old (cdr l)))
          )
          (else
            (cons (car l) (subst* new old (cdr l)))
          )
        )
      )
      (else
        (cons
          (subst* new old (car l))
          (subst* new old (cdr l))
        )
      )
    )
  )
)
```

###  What is `(insertL* new old l)` where `new` is pecker `old` is chuck and `l` is
### ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood)
`((how much (wood)) could ((a (wood) pecker chuck)) (((pecker chuck))) (if (a) ((wood pecker chuck))) (could pecker chuck wood)`

### Write `insertL*`
```
(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
        (cond
          ((eq? (car l) old)
            (cons
              new
              (cons old (insertL* new old (cdr l)))
            )
          )
          (else
            (cons
              (car l)
              (insertL* new old (cdr l))
            )
          )
        )
      )
      (else
        (cons
          (insertL* new old (car l))
          (insertL* new old (cdr l))
        )
      )
    )
  )
)
```

### `(member* a l)` where `a` is chips and `l` is ((potato) (chips ((with) fish) (chips)))
True

### Write member*
```
(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
        (or
          ((eq? (car l) a) #t)
          (member* a (cdr l))
        )
      )
      (else
        (or
          (member* a (car l))
          (member* a (cdr l))
        )
      )
    )
  )
)
```

### What is `(leftmost l)` where `l` is ((potato) (chips ((with) fish) (chips)))
`potato`

### What is `(leftmost l)` where `l` is (((hot) (tuna (and))) cheese)
`hot`

### What is `(leftmost l)` where `l` is (((() four)) 17 (seventeen))
No answer.

### What is `(leftmost '())`?
No answer

### Can you describe what `leftmost` does?
Finds the leftmost atom in a non-empty list of S-expressions if that list does not contain the empty list.

### Is `leftmost` a *-function?
No, it works on lists of S-expressions, but it only recurs on the `car`.

### Does `leftmost` need to ask questions about all three possible cases?
No, it only needs to ask two questions. We agreed that leftmost works on non-empty lists that don't contain empty lists.

### Write `leftmost`
```
(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l)) (car l))
      (else
        (leftmost (car l))
      )
    )
  )
)
```

### Do you remember what `(or ... )` does?
`(or ... )` asks questions one at a time until it finds one that is true.
Then `(or ... )` stops, making its value true.
If it cannot find a true argument, the value of `(or ... )` is false.

### What is `(and (atom? (car l)) (eq? (car l) x))` where `x` is pizza and `l` is (mozzarella pizza)
False, `((eq? (car l) x)` => `#f`

### What is `(and (atom? (car l)) (eq? (car l) x))` where `x` is pizza and `l` is ((mozzarella mushroom) pizza)
False, `(atom? (car l))` => `#f`

### Give an example for `x` and `l` where `(and (atom? (car l)) (eq? (car l) x))` is true.
l => `(banana bread)`
x => banana

### Put in your own words what `(and ... )` does.
`(and ... )` asks questions one at the time until it finds one that is false.
Then it stops, making its value false.
If it cannot find a false argument its value is true.

### True or false: it is possible that one of the arguments of (and ... ) and (or ... ) is not considered?
True, because `(and ... )` stops if the first argument has the value #f
and `(or ... )` stops if the first argument has the value #t .

### `(eqlist? l1 l2)` where `l1` is (strawberry ice cream) and `l2` is (strawberry ice cream)
True

### `(eqlist? l1 l2)` where `l1` is (strawberry ice cream) and `l2` is (strawberry cream ice)
False

### `(eqlist? l1 l2)` where `l1` is (banana ((split))) and `l2` is ((banana) (split))
False

### `(eqlist? l1 l2)` where `l1` is (beef ((sausage)) (and (soda))) and `l2` is (beef ((salami)) (and (soda)))
False

### `(eqlist? l1 l2)` where `l1` is (beef ((sausage)) (and (soda))) and `l2` is (beef ((sausage)) (and (soda)))
True

### What is `eqlist?`
Its a function that receives two lists of S-expressions and checks if they are equal

### How many questions will `eqlist?` have to ask about its arguments?
Nine

### Can you explain why there are nine questions?
Each argument may be either
* empty,
* an atom consed onto a list, or
* a list consed onto a list.
For example, at the same time as the first argument may be the empty list,
the second argument could be the empty list or have an atom or a list in the `car` position

### Write `eqlist?` `using eqan?`
```
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      ((and (atom? (car l1)) (atom? (car l2)))
        (and
          (eqan? (car l1) (car l2))
          (eqlist? (cdr l1) (cdr l2))
        )
      )
      ((or (atom? (car l1)) (atom? (car l2))) #f)
      (else
        (and
          (eqlist? (car l1) (car l2))
          (eqlist? (cdr l1) (cdr l2))
        )
      )
    )
  )
)
```

### What is an S-expression?
An S-expression is a list or an atom

### How many questions does `equal?` ask to determine whether two S-expressions are the same?
Four.
The first argument may be an atom or a list of S-expressions at the same time
as the second argument may be an atom or a list of S-expresssions.

### Write `equal?`
```
(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2))
    )
  )
)
```

### Now, rewrite eqlist? using equal?
```
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      ((equal? l1 l2) #t)
      (else
        (and
          (eqlist? (car l1) (car l2))
          (eqlist? (cdr l1) (cdr l2))
        )
      )
    )
  )
)
```
