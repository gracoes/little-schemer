### What is `(looking a lat)` where `a` is caviar and `lat` is (6 2 4 caviar 5 7 3)
`#t`

### What is `(looking a lat)` where `a` is caviar and `lat` is (6 2 grits caviar 5 7 3)
`#f`

### Were you expecting something different?
Yes, caviar is in `lat`

### True enough, but what is the first number in the `lat`?
6

### And what is the sixth element of `lat`?
7

### And what is the seventh element?
3

### So `looking` clearly can't find caviar...
True enough, because the third element is grits, which does not even resemble caviar.

### Here is looking
```
(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))
```
### Write `keep-looking`
```
(define keep-looking
  (lambda (a s lat)
    (cond
      ((number? s)
        (keep-looking a (pick s lat) lat))
      (else
        (eq? s a)
      )
    )
  )
)
```

### What is unusual about `keep-looking`
It doesn't reccur on a part of `lat`.
We call this "unnatural" recursion.

### Does `keep-looking` appear to get closer to its goal?
No

### Does it always get closer to its goal?
No, if `lat` is a list of numbers

### What is `(looking a lat)` where `a` is caviar and `lat` is (7 1 2 caviar 5 6 3)
No answer, since the seventh element is 3 wich calls `keep-looking` for the third element which is 2 and
that calls `keep-looking` for the first element which is 7 which makes it go back to the beggining.

### Functions like `looking` are called partial functions.
### What do you think the functions we have seen so far are called?
Total functions

### Can you define a shorter function that does not reach its goal for some of its arguments?
```
(define eternity
  (lambda (x)
    (eternity x)))
```

### For how many of its arguments does `eternity` reach its goal?
Zero

### Is `eternity` partial?
Yes, it's the most partial function

### What is (shift x) where `x` is ((a b) c)
`(a (b c))`

###  What is (shift x) where `x` is ((a b) (c d))
`(a (b (c d)))`

### Define `shift`
```
(define shift
  (lambda (pair)
    (build
      (first (first pair))
      (build
        (second (first pair))
        (second pair)))
  )
)
```

### Describe what `shift` does.
The function shift takes a pair whose first component is a pair and
builds a pair by shifting the second part of the first component into the second component.

### Now look at this function:
```
(define align
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora))
        (align (shift pora)))
      (else
        (build
          (first pora)
          (align (second pora)))))))
```
### What does it have in common with `keep-looking`
Both functions change their arguments for their recursive uses
but in neither case is the change guaranteed to get us closer to the goal.

### Why are we not guaranteed that `align` makes progress?
In the second cond-line `shift` creates an argument for `align` that is not a part of the original argument.

### Which commandment does that violate?
The seventh commandment

### Is the new argument at least smaller than the original one?
No

### Why not?
Because `shift` just shuffles the elements of `pora` which mantains it's length.

### Can you write a function that counts the number of atoms in align's arguments?
```
(define length*
  (lambda (l)
    (cond
      ((null? l) 0)
      ((atom? (car l)) (add1 (length* (cdr l))))
      (else
        (+ (length* (car l)) (length* (cdr l)))
      )
    )
  )
)
```

### Is `align` a partial function?
We don't know yet. There may be arguments for which it keeps aligning things.

### Is there something else that changes about the arguments to `align` and its recursive uses?
Yes, there is.
The first component of a pair becomes simpler, though the second component becomes more complicated.

### In what way is the first component simpler?
It loses elements

### Doesn't this mean that length* is the wrong function for determining the length of the argument?
### Can you find a better function?
A better function should pay more attention to the first component.

### How much more attention should we pay to the first component?
At least twice as much.
