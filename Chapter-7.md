###  Is this a set? (apple peaches apple plum)
No, apple is repeated.

### True or false: `(set? lat)` where `lat` is (apples peaches pears plums)
True.

### How about `(set? lat)` where `lat` is ()
True

### Try to write set?
```
(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else
        (set? (cdr lat))
      )
    )
  )
)
```

### Does this work for the example (apple 3 pear 4 9 apple 3 4)
Yes, its false

### Were you surprised to see the function `member?` appear in the definition of `set?`
No because `member?` checks if there an atom exists in a lat and `set?` can only have an atom appear once

###  What is `(make-set lat)` where lat is (apple peach pear peach plum apple lemon peach)
`(apple peach pear plum lemon)`

### Try to write `make-set` using `member?`
```
(define make-set
  (lambda (lat)
    (cond
      ((null? lat) '())
      (else
        (cons
          (car lat)
          (make-set
            (multirember (car lat) (make-set (cdr lat))))
        )
      )
    )
  )
)
```

### Describe in your own words how the definition of `make-set` works.
The function makeset remembers to `cons` the first atom in the lat onto the result of the natural recursion,
after removing all occurrences of the first atom from the rest of the lat.

### Does `make-set` work for the example (apple 3 pear 4 9 apple 4)
Yes, it returns `(apple 3 pear 4 9)`

### What is `(subset? setl set2)` where
### `set1` is (5 chicken wings) and
### `set2` is (5 hamburgers 2 pieces fried chicken and light duckling wings)
True, because each atom in `set1` is also in `set2`

### What is (subset`? setl set2)` where
### `set1` is (4 pounds of horseradish) and
### `set2` is (four pounds chicken and 5 ounces horseradish)
False, beacuse the atoms `4` and `of` of `set1` are not in `set2`

### Write `subset?`
```
(define subset?
  (lambda (set1 set2)
    (and (member? (car lat) set2) (subset? (cdr set1) set2))
  )
)
```

### What is `(eqset? set1 set2)` where
### `set1` is (6 large chickens with wings) and
### `set2` is (6 chickens with large wings)
True

### Write `eqset?`
```
(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2) (subset? set2 set1))
  )
)
```

### What is `(intersect? set1 set2)` where
### `set1` is (stewed tomatoes and macaroni) and
### `set2` is (macaroni and cheese)
True because atleast one of the atoms in `set1` is present in `set2`

### Define `intersect?`
```
(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1) #f)
      (else
        (or (member? (car set1) set2) (intersect (cdr set1) set2))
      )
    )
  )
)
```

### What is `(intersect set1 set2)` where
### `set1` is (stewed tomatoes and macaroni) and
### `set2` is (macaroni and cheese)
`(and macaroni)`

### Now you can write the short version of `intersect`
```
(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2)
        (cons (car set1) (intersect (cdr set1) set2))
      )
      (else
        (intersect (cdr set1) set2)
      )
    )
  )
)
```

### What is `(union set1 set2)` where
### `set1` is (stewed tomatoes and macaroni casserole) and
### `set2` is (macaroni and cheese)
`(stewed tomatoes casserole macaroni and cheese)`

### Write `union`
```
(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2)
        (union (cdr set1) set2))
      (else
        (cons
          (car set1)
          (union (cdr set1) set2)
        )
      )
    )
  )
)
```

### What is this function?
```
(define xxx
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2)
        (xxx (cdr set1) set2))
      (else
        (cons
          (car set1)
          (xxx (cdr set1) set2))))))
```

It is a function that returns all the atoms
in `set1` that are not in `set2`.
That is, `xxx` is the (set) difference (-) function.

### What is `(intersectall l-set)` where `l-set` is ((a b c) (c a d e) (e f g h a b))
`(a)`

### What is `(intersectall l-set)` where
### `l-set` is ((6 pears and) (3 peaches and 6 peppers) (8 pears and 6 plums) (and 6 prunes with some apples))
`(6 and)`

### Now, using whatever help functions you need, write `intersectall` assuming that the list of sets is non-empty
```
(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set)) (car l-set))
      (else
        (intersect (car l-set) (intersectall (cdr l-set)))
      )
    )
  )
)
```
