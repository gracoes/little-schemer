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

###  Do you mean something like weight*
```
(define weight*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else
        (+ (x (weight* (first pora)) 2) (weight* (second pora)))))))
```

### What is `(weight* x)` where `x` is ((a b) c)
7

### And what is `(weight* x)` where `x` is (a (b c))
5

### Does this mean that the arguments get simpler?
It appears so, the `weight*`'s of `align`'s arguments become successively smaller.

### Is align a partial function?
No, it yields a value for every argument.

### Here is `shuffle` which is like `align` but uses `revpair` from chapter 7, instead of `shift`:
```
(define shuffle
  (lambda (pora)
    (cond
      ((a-pair? (first pora))
        (shuffle (revpair pora)))
      (else
        (build (first pora) (shuffle (second pora)))))))
```
The functions `shuffle` and `revpair` swap the components of pairs when the first component is a pair.

### Does this mean that shuffle is total?
Maybe

### Let's try it. What is the value of `(shuffle x)` where `x` is (a (b c))
No answer

### Okay, let's try something interesting. What is the value of `(shuffle x)` where `x` is ((a b) (c d))
To determine this value, we need to find out what `(shuffle (revpair pora))` is where `pora` is ((a b) (c d)).

### And how are we going to do that?
We are going to determine the value of `(shuffte pora)` where `pora` is ((c d) (a b)).

###  Doesn't this mean that we need to know the value of `(shuffle (revpair pora))`
### where `(revpair pora)` is ((a b) (c d))
We are back at the starting point.
The function `shuffle` is not total because it now swaps the components of the pair again,
which means that we start all over.

### Is this function total?
```
(define C
  (lambda (n)
    (cond
      ((one? n) 1)
      (else
        (cond
          ((even? n) (C (/ n 2)))
          (else
            (C (add1 (x 3 n)))))))))
```
It doesn't yield a value for 0, but otherwise nobody knows. Thank you, Lothar Collatz
(1910-1990).

### What is the value of `(A 1 0)`
2

### `(A 1 1)`
3

### `(A 2 2)`
5

### Here is the definition of A
```
(define A
  (lambda (n m)
    (cond
    ((zero? n) (add1 m))
    ((zero? m) (A (sub1 n) 1))
    (else
      (A (sub1 n)
        (A n (sub1 m)))))))
```
Thank you, Wilhelm Ackermann (1853-1946).

### What does `A` have in common with `shuffle` and `looking`
`A`'s arguments, like `shuffle`'s and `looking`'s, do not necessarily decrease for the recursion.

### How about an example?
That's easy: `(A 1 2)` needs the value of `(A 0 (A 1 1))`.
And that means we need the value of `(A 0 3)`.

### Does A always give an answer?
Yes, it is total

### Then what is `(A 4 3)`
For all practical purposes, there is no answer.

### What does that mean?
The page that you are reading now will have decayed long
before we could possibly have calculated the value of `(A 4 3)`.

### Wouldn't it be great if we could write a function
### that tells us whether some function returns with a value for every argument?
Yes, that would be nice

### Okay, let's write it.
It sounds complicated. A function can work for many different arguments.

### Then let's make it simpler.
### For a warm-up exercise, let's focus on a function that checks whether
### some function stops for just the empty list, the simplest of all arguments.
### Here is the beginning of this function:
```
(define will-stop?
  (lambda (f)
    ...))
```
### Can you fill in the dots?
```
(define will-stop?
  (lambda (f)
    (cond
      ((f '()) #t)
      (else #f)
    )
  )
)
```

### Does `will-stop?` return a value for all arguments?
That's the easy part: we said that it either returns `#t` or `#f`,
depending on whether the argument stops when applied to `()`.

### Is `will-stop?` total then?
It seems like that.

### Then let's make up some examples. Here is the first one.
### What is the value of `(will-stop? f)` where `f` is `length`
True

### Absolutely. How about another example? What is the value of `(will-stop? eternity)`
It should be false, but as we apply `eternity` to `()` it will never return

### Okay, here is a function that could be an interesting argument for `will-stop?`
```
(define last-try
  (lambda (x)
    (and (will-stop? last-try) (eternity x))))
```
### What is (will-stop? last-try)
It's the result of `last-try` applied to `()`, which is the result of `(will-stop? last-try)` again, which means
it will never return

### We need to test it on `()`
If we want the value of `(last-try '())`, we must determine the value of
`(and (will-stop? last-try) (eternity '()))`.

### What is the value of `(and (will-stop? last-try) (eternity '()))`
That depends on the value of `(will-stop? last-try)`.

### There are only two possibilities. Let's say `(will-stop? last-try)` is `#f`
Okay, then `(and #f (eternity '()))`, is `#f`, since `(and #f ... )` is always `#f`.

### So (last-try '()) stopped, right?
Yes

### But didn't will-stop? predict just the opposite?
Yup, we said that the value of `(will-stop? last-try)` was `#f`, which really means that `last-try` will not stop.
