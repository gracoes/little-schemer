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

### Is this a pair? (pear pear)
Yes, because it is a list with only two atoms.

###  Is this a pair? (3 7)
Yes, because it is a list with only two numbers.

### Is this a pair? ((2) (pair))
Yes, because it is a list with two S-expressions

### `(a-pair? l)` `l`  where is (full (house))
True

### Define `a-pair?`
```
(define a-pair?
  (lambda (l)
    (cond
      ((null? l) #f)
      ((atom? l) #f)
      (else
        (eq? (length l) 2)
      )
    )
  )
)
```

### How can you refer to the first S-expression of a pair?
`car` of pair

### How can you refer to the second S-expression of a pair?
`car` of `cdr` of pair

### How can you build a pair with two atoms?
`cons` the first atom into the `cons` of the second one with the empty list.
`(cons x1 (cons x2 '()))`

### How can you build a pair with two S-expressions?
`cons` the first S-expression into the `cons` of the second one with the empty list.

### Did you notice the differences between the last two answers?
Nope

### What possible uses do these three functions have?
```
(define first
  (lambda (p)
    (cond
      (else (car p)))))

(define second
  (lambda (p)
    (cond
      (else (car (cdr p))))))

(define build
  (lambda (s1 s2)
    (cond
      (else (cons s1
              (cons s2 '())))))
```
Obtain the first element of the pair, obtain the second element of the pair and build a pair from two S-expressions.

### Redefine first, second, and build as one-liners
```
(define first
  (lambda (p)
    (car p)
  )
)

(define second
  (lambda (p)
    (car (cdr p))
  )
)

(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 '()))
  )
)
```

### Can you write third as a one-liner?
```
(define third
  (lambda (l)
    (car (cdr (cdr l)))
  )
)
```

### Is `l` a rel where `l` is (apples peaches pumpkin pie)
No, since `l` is not a list of pairs. We use rel to stand for relation.

### Is `l` a rel where `l` is ((apples peaches) (pumpkin pie) (apples peaches))
No, since `l` is not a set of pairs.

### Is `l` a rel where `l` is ((apples peaches) (pumpkin pie))
Yes, since `l` is a set of pairs.

### Is `l` a rel where `l` is ((4 3) (4 2) (7 6) (6 2) (3 4))
Yes, since `l` is a set of pairs.

### Is `rel` a fun where `rel` is ((4 3) (4 2) (7 6) (6 2) (3 4))
No. We use fun to stand for function

### What is `(fun? rel)` where `rel` is ((8 3) (4 2) (7 6) (6 2) (3 4))
#t, because `(firsts rel)` is a set

### What is `(fun? rel)` where `rel` is ((d 4) (b 0) (b 9) (e 5) (g 4))
False, because `(firsts rel)` is not a set (`b` is repeated)

### Write `fun?` with `set?` and `firsts`
```
(define fun?
  (lambda (rel)
    (set? (firsts rel))
  )
)
```

### How do we represent a finite function?
For us, a finite function is a list of pairs
in which no first element of any pair is the same as any other first element.

### What is `(revrel rel)` where `rel` is ((8 a) (pumpkin pie) (got sick))
`((a 8) (pie pumpkin) (sick got))`

### You can now write `revrel`
```
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else
        (cons
          (build (second (car rel)) (first (car rel)))
          (revrel (cdr rel))
        )
      )
    )
  )
)
```

### Would the following also be correct:
```
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else
        (cons
          (cons
              (car (cdr (car rel)))
              (cons
                (car (car rel)) '())
          (revrel (cdr rei)))))))
```
Yes, it's the same without using `first`, `second` and `build`

### Suppose we had the function revpair that reversed the two components of a pair like this:
```
(define revpair
  (lambda (p)
    (build (second p) (first p))
  )
)
```
### How would you rewrite `revrel` to use this help function?
```
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else
        (cons
          (revpair (car rel))
          (revrel (cdr rel))
        )
      )
    )
  )
)
```


### Can you guess why `fun` is not a fullfun where `fun` is ((8 3) (4 2) (7 6) (6 2) (3 4))
Because the `2` appears more than once as a second item of a pair.

### Why is `#t` the value of `(fullfun? fun)` where `fun` is ((8 3) (4 8) (7 6) (6 2) (3 4))
`fun` is a fullfun since no second item of a pair appears more than once.

### What is `(fullfun? fun)` where `fun` is ((grape raisin) (plum prune) (stewed prune))
False

### What is `(fullfun? fun)` where `fun` is ((grape raisin) (plum prune) (stewed grape))
True

### Define fullfun?
```
(define fullfun?
  (lambda (fun)
    (set? (seconds fun))
  )
)
```

### Can you define `seconds`
```
(define seconds
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else
        (cons
          (second (car rel))
          (seconds (cdr rel))
        )
      )
    )
  )
)
```

### What is another name for `fullfun?``
`one-to-one?`

### Can you think of a second way to write `one-to-one?`
```
(define one-to-one?
  (lambda (fun)
    (fun? (revrel fun))
  )
)
```

### Is ((chocolate chip) (doughy cookie)) a one-to-one function?
You bet
