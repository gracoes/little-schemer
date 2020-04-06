### Is 14 an atom?
Yes because all numbers are atoms

### Is (atom? n) true or false where n is 14
True

### Is -3 a number?
Yes

### Is 3.14159 a number?
Yes

### What is `(add1 n)` where n is 67
68

### What is `(subl1 n)` where n is 5
4

### Is (zero? 0) true or false?
True

### Is (zero? 1492) true or false?
False

### What is (myadd 46 12)?
58

### Write the function myadd
(define myadd
  (lambda (n1 n2)
    (cond
      ((zero? n2) n1)
      (else
        (myadd (add1 n1) (sub1 n2))
      )
    )
  )
)

### What is (mysub 14 3)
11

### What is (mysub 18 25)
No answer. There are no negative numbers

### Try to write mysub
(define mysub
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else
        (mysub (sub1 n) (sub1 m))
      )
    )
  )
)

### Can you describe how (mysub n m) works?
mysub takes 2 numbers and subtracts 1 to `n` `m` times.

### Is this a tup? (2 11 3 79 47 6)
Yes

### Is this a tup? (8 55 55 55)
Yes

### Is this a tup? (1 2 8 apple 4 3)
No

### Is this a tup? (3 (74) 13 9)
No

### Is this a tup? ()
No

### What is (addtup tup) where `tup` is (3 5 2 8)
18

### What is (addtup tup) where `tup` is (15 6 7 12 3)
43

### What does `addtup` do?
It returns the addition of all the numbers in a tuple

### What is the natural way to build numbers from a list?
myAdd

### When building lists with `cons` the value of the terminal condition is `()`.
### What should be the value of the terminal condition when building numbers with `myadd`?
0


### What is the natural terminal condition for a list?
If a list is empty => `(null? l)`

### What is the natural terminal condition for a tup?
The same as list.

###  When we build a number from a list of numbers, what should the terminal condition line look like?
`((null? tup) 0)`

### What is the terminal condition line of `addtup`
`((null? tup) 0)`

### How is a `lat` defined?
A list of atoms or the empty list.

### How is a tup defined?
A list of numbers or the empty list.

### What is used in the natural recursion on a list?
`(cdr lat)`

### What is used in the natural recursion on a tup?
`(cdr tup)`

### Why?
Because `tup` is also a list.

### How many questions do we need to ask about a list?
Two, `(null? l)` and `else`

### How many questions do we need to ask about a tup?
Two, `(null? tup)` and `else`

### How is a number defined?
It is either zero or it is one added to a rest, where rest is again a number.

### What is the natural terminal condition for numbers?
(zero? n)

### What is the natural recursion on a number?
(sub1 n)

### How many questions do we need to ask about a number?
Two, `(zero? n)` and `else`

### What does `cons` do?
It builds a list by adding an S-expression to the beginning of another list.

### What is the terminal condition line of `addtup`?
`((null? tup) 0)`

### What is the natural recursion for `addtup`?
`(addtup (cdr tup))`

### What does `addtup` use to build a number?
`myadd`

### Define the function `addtup`
```
(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else
        (myadd
          (car tup)
          (addtup (cdr tup))
        )
      )
    )
  )
)
```

### What is (x 5 3)
15

### What is (x 13 4)
52

### What does (x n m) do?
It mutiplies `n` by `m`, which means it adds `n` to `n` `m` times.

### What is the terminal condition line for x?
`(zero? m)`

### Since `(zero? m)` is the terminal condition, `m `must eventually be reduced to zero.
### What function is used to do this?
`sub1`

### What is another name for `(x n (sub1 m))` in this case?
Its the natural recursion of `x`

### Write the function `x`
```
(define x
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else
        (myadd
          n
          (x n (sub1 m))
        )
      )
    )
  )
)
```

### What is (x 12 3)
36

### Again, why is 0 the value for the terminal condition line in `x`
Because n + 0 = n

### What is (tup+ tup1 tup2) where `tup1` is (3 6 9 11 4) and `tup2` is (8 5 2 0 7)
`(11 11 11 11 11)`

###  What is (tup+ tup1 tup2) where `tup1` is (2 3) and `tup2` is (4 6)
`(6 9)`

### What does (tup+ tup1 tup2) do?
It adds the first number of tup1 to the first number of tup2, then it adds the second number of tup1
to the second number of tup2, and so on, building a tup of the answers, for tups of the same length.

### What is unusual about `tup+`?
It recurs on two tuples.

### If you recur on one tup how many questions do you have to ask?
Two

### When recurring on two tups, how many questions need to be asked about the tups?
Four

### Do you mean the questions
```
(and (null? tup1) (null tup2))
(null? tup1)
(null? tup2)
else
```

### Can the first tup be `()` at the same time as the second is other than `()`?
No because the tups must have the same length

### Does this mean `(and (null? tup1) (null? tup2))` and `else` are the only questions we need to ask?
Yes

###  Write the function tup+
```
(define tup+
  (lambda (tup1 tup2)
    (cond
      ((and (null? tup1) (null? tup2)) '())
      (else
        (cons
          (myadd (car tup1) (car tup2))
          (tup+ (cdr tup1) (cdr tup2))
        )
      )
    )
  )
)
```









