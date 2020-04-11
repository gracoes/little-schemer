### Is 1 an arithmetic expression?
Yes

### Is 3 an arithmetic expression?
Yes

### Is 1 + 3 an arithmetic expression?
Yes

### Is 1 + 3 x 4 an arithmetic expression?
Yes

### Is cookie an arithmetic expression?
Yes

### And, what about 3^Y + 5?
Yes

### What is an arithmetic expression in your words?
For the purpose of this chapter, an
arithmetic expression is either an atom (including numbers),
or two arithmetic expressions combined by `+`, `x`, or `expt`.

### What is `(quote a)`
a

### What is `(quote +)`
+

### What does `(quote x)` stand for?
The atom `x`

### Is `(eq? 'a y)` true or false where `y` is a
True

### Is (eq? x y) true or false where `x` is a and `y` is a
True

### Is (n + 3) an arithmetic expression?
Not really, since there are parentheses around n + 3.
Our definition of arithmetic expression does not mention parentheses.

### Could we think of (n + 3) as an arithmetic expression?
Yes

### What would you call (n + 3)?
We call it a representation for n + 3.

### Why is (n + 3) a good representation?
Because
* (n + 3) is an S-expression. It can therefore serve as an argument for a function.
* it's pretty similar to the original.

### True or false: `(numbered? x)` where x is 1
True

### How do you represent 3 + 4 x 5
(3 + (4 x 5))

### True or false: `(numbered? y)` where y is (3 + (4 ^ 5))
True

### True or false: `(numbered? z)` where z is (2 x sausage)
False

### What is numbered?
It's a function that receives an arithmetic expression as an argument
and checks if all the arithmetic expressions are numbers besides the operations, + x ^

### Now can you write a skeleton for `numbered?`
```
(define numbered?
  (lambda (aexp)
    (cond
      (-- ---)
      (--- ---)
      (--- ---)
      (--- --)
    )
  )
)
```

### What is the first question?
`atom? aexp`

### What is (eq? (car (cdr aexp)) '+)
The second question, it checks if the second element of `aexp` is the atom `+`

### Can you guess the third one?
`(eq? (car (cdr aexp)) 'x)`

### And you must know the fourth one.
`(eq? (car (cdr aexp)) '^)`

### Should we ask another question about `aexp`
No! So we could replace the previous question by `else`.

### Why do we ask four, instead of two, questions about arithmetic expressions?
### After all, arithmetic expressions like (1 + 3) are lats.
Because we consider (1 + 3) as a representation of an arithmetic expression in list form, not as a list itself.
And, an arithmetic expression is either a number, or two arithmetic expressions combined by +, x,or t.

### Now you can almost write numbered?
```
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (car (cdr aexp)) '+)
        (and
          (numbered? (car aexp))
          (numbered? (car (cdr (cdr aexp))))
        )
      )
      ((eq? (car (cdr aexp)) 'x)
        (and
          (numbered? (car aexp))
          (numbered? (car (cdr (cdr aexp))))
        )
      )
      (else
        (and
          (eq? (car (cdr aexp)) '^)
            (and
              (numbered? (car aexp))
              (numbered? (car (cdr (cdr aexp)))))
        )
      )
    )
  )
)
```

### Why do we ask `(number? aexp)` when we know that aexp is an atom?
Because a word is also an atom and we just want numbers

### What do we need to know if the aexp consists of two arithmetic expressions combined by +
We need to know if the two arithmetic expressions are numbers

### In which position is the first subexpression?
Its the `car` of exp

### In which position is the second subexpression?
Its the `car` of `cdr` of `cdr` of exp

### So what do we need to ask?
If `car` of exp and `car` of `cdr` of `cdr` of exp are numbered?
```
(and (numbered? (car aexp))
  (numbered? (car (cdr (cdr aexp))))
)
```

### Since aexp was already understood to be an arithmetic expression, could we have written numbered? in a simpler way?
Yes
```
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else
        (and
          ((numbered? (car aexp)))
          (numbered? (car (cdr (cdr aexp))))
        )
      )
    )
  )
)
```

### What is `(value u)` where u is 13
13

### `(value x)` where x is (1 + 3)
4

### `(value y)` where y is (1 + (3 ^ 4))
82

### `(value z)` where z is cookie
No answer

### Define `(value nexp)`
`(value nexp)` returns what we think is the natural value of a numbered arithmetic expression.

### How many questions does `value` ask about `nexp`
Four

### Now, let's attempt to write `value`
```
(define value
  (lambda (nexp)
    (cond
      ((atom? (car nexp)) ...)
      ((eq? (car (cdr nexp)) '+) ...)
      ((eq? (car (cdr nexp)) 'x) ...)
      (else
        ...
      )
    )
  )
)
```

### What is the natural value of an arithmetic expression that is a number?
That number

### What is the natural value of an arithmetic expression that consists of two arithmetic expressions combined by +
The sum of both arithmetic expressions if they are both numbers

### Can you think of a way to get the value of the two subexpressions in (1 + (3 x 4))
The first expression is just `1` and the second is the value of `(x 3 4)`
We can apply `value` to both expressions

### And in general?
We can do the same

### Give `value` another try.
```
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car (cdr nexp)) '+) (+ (value (car nexp)) (value (car (cdr (cdr nexp))))))
      ((eq? (car (cdr nexp)) 'x) (x (value (car nexp)) (value (car (cdr (cdr nexp))))))
      (else
        (expt (value (car nexp)) (value (car (cdr (cdr nexp)))))
      )
    )
  )
)
```

### Can you think of a different representation of arithmetic expressions?
(+ 3 4)

### Could (3 4 +) represent 3 + 4
I guess

### Could (+ 3 4)
Yep

### Or (plus 3 4)
Also yes

### Is (+ (x 3 6) (expt 8 2)) a representation of an arithmetic expression?
Yes

### Try to write the function value for a new kind of arithmetic expression that is either:
### - a number
### - a list of the atom + followed by two arithmetic expressions,
### - a list of the atom x followed by two arithmetic expressions, or
### - a list of the atom expt followed by two arithmetic expressions.
```
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car nexp) '+) (+ (value (car (cdr nexp))) (value (car (cdr (cdr nexp))))))
      ((eq? (car nexp) 'x) (x (value (car (cdr nexp))) (value (car (cdr (cdr nexp))))))
      (else
        (expt (value (car (cdr nexp))) (value (car (cdr (cdr nexp)))))
      )
    )
  )
)
```

### Let's write a function `1st-sub-exp `for arithmetic expressions.
```
(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))
  )
)
```

### Write `2nd-sub-exp` for arithmetic expressions
```
(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))
  )
)
```

### Finally, let's replace `(car nexp)` by `(operator nexp)`
```
(define operator
  (lambda (aexp)
    (car aexp)
  )
)
```

### Now write `value` again.
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

### Have we seen representations before?
Yes

### For what entities have we used representations?
Lists, functions, boolean values, numbers

### Numbers are representations?
Yes. For example 4 stands for the concept four.
We chose that symbol because we are accustomed to arabic representations.

### What else could we have used?
Any symbol repeated four times or IV for example, even '(() () () ())

### Do you remember how many primitives we need for numbers?
Four => `number?`, `zero?`, `add1`, `sub1`

### Let's try another representation for numbers. How shall we represent zero now?
`()`

### How is one represented?
`(())`

### How is two represented?
`(() ())`

### Got it? What's three?
`(() () ())`

### Write a function to test for zero.
```
(define sero?
  (lambda (n)
    (null? n)
  )
)
```

### Can you write a function that is like `add1`
```
(define edd1
  (lambda (n)
    (cons '() n)
  )
)
```

### What about `sub1`
```
(define zub1
  (lambda (n)
    (cdr n)
  )
)
```

### Is this correct?
It won't work if n is zero, but thats fine (see The Law of Cdr)

### Rewrite `myadd` using this representation.
```
(define myadd
  (lambda n1 n2
    (cond
      ((sero? n2) n1)
      (else
        (edd1 (myadd n1 (zub1 n2)))
      )
    )
  )
)
```

### Has the definition of `myadd` changed?
Yes and no. It changed, but only slightly.

###  Recall `lat?``
`lat?` is a function that takes a list and checks if it is a list of atoms.

### Do you remember what the value of `(lat? ls)` is where ls is (1 2 3)
True

### What is (1 2 3) with our new numbers?
`((()) (() ()) (() () ())`

### What is `(lat? ls)` where ls is ((()) (()()) (()()()))
False

### Is that bad?
You must beware of shadows (representations).
