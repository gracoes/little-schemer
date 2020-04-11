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

