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

### So we must have been wrong about `(will-stop? last-try)`
That's correct. It must return `#t`, because `will-stop?` always gives an answer. We said it was total.

### Fine. If `(will-stop? last-try)` is `#t` what is the value of `(last-try '())`
Now we just need to determine the value of `(and #t (eternity '())`, which is the same as the value of `(eternity '())`.

### What is the value of `(eternity '())`
It doesn't have one since it doesn't stop.

### But that means we were wrong again!
True, since this time we said that `(will-stop? last-try)` was `#t`.

### What do you think this means?
We took a really close look at the two
possible cases. If we can *define* `will-stop?`, then
`(will-stop? last-try)` must yield either `#t` or `#f`.
But it cannot-due to the very definition of what `will-stop?` is supposed to do.
This must mean that `will-stop?` cannot be *defined*

### Is this unique?
Yes, it is. It makes `will-stop?` the first function that we can describe precisely but cannot *define* in our language.

### Is there any way around this problem?
No. Thank you, Alan M. Turing (1912-1954) and Kurt Godel (1906-1978).

### What is `(define ... )`
Its a call to the function `define`

### Is this the function length
```
(define length
  (lambda (l)
    (cond
      ((null? l) 0)
      (else
        (add1 (length (cdr l)))))))
```
Yep

### What if we didn't have `(define ... )` anymore? Could we still define `length`
I guess not.
Without `(define ... )` nothing, and especially not the body of `length`, could refer to `length`

###  What does this function do?
```
(lambda (l)
  (cond
    ((null? l) 0)
    (else
      (add1 (eternity (cdr l)))))))
```
It determines the length of the empty list and nothing else.

### What happens when we use it on a non-empty list?
It doesn't stop

### What does it mean for this function that looks like `length`
It's partial, it just won't give any answer for non-empty lists.

### Suppose we could name this new function. What would be a good name?
length0

### How would you write a function that determines the length of lists that contain one or fewer items?
```
(define length1
  (lambda
    (cond
      ((null? l) 0)
      (else
        (add1 (length0 (cdr l)))
      )
    )
  )
)
```

### Almost, but `(define ... )` doesn't work for `length0`
So, replace length0 by its definition.
```
(define length1
  (lambda
    (cond
      ((null? l) 0)
      (else
        (add1
          ((lambda (l)
            (cond
              ((null? l) 0)
              (else
                (add1 (eternity (cdr l)))
              ))
            )
          )
        )
      )
    )
  )
)
```

### Is this the function that would determine the lenghts of lists that contain two or fewer items?
```
(lambda
    (cond
      ((null? l) 0)
      (else
        (add1
          ((lambda (l)
            (cond
              ((null? l) 0)
              (else
                (add1
                  ((lambda (l)
                    (cond
                      ((null? l) 0)
                      (else
                        (add1 (eternity (cdr l))))))
                  (cdr l)
                )
            )
          )
        )
      )
    (cdr l)))))
)
```
Yes, this is length2

### Now, what do you think recursion is?
What do you mean?

### Well, we have seen how to determine the length of a list with no items, with no more than one item,
### with no more than two items, and so on.
### How could we get the function `length` back?
If we could write an infinite function in the style of `length0`, `length1'`, `length2'` ... ,
then we could write length-infinite, which would determine the length of all lists that we can make.

### How long are the lists that we can make?
Infinite

### But we can't write an infinite function.
### And we still have all these repetitions and patterns in these functions.
### What do these patterns look like?
All these programs contain a function that looks like length.
Perhaps we should abstract out this function: see The Ninth Commandment.

### We need a function that looks just like length but starts with `(lambda (length) ... )`.
Do you mean this?
```
((lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else
        (add1 (length (cdr l)))))))
  eternity)
```

### Rewrite `length1` in the same style.
```
(
  (lambda (f)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else
          (add1 (f (cdr l)))
        )
      )
    )
  )
  (
    (lambda (g)
      (cond
        ((null? l) 0)
        (else
          (add1 (g (cdr l)))
        )
      )
    )
    eternity
  )
)
```

### Do we have to use `length` to name the argument?
Not really

### How about length2
```
(
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else
          (add 1 (length (cdr l)))
        )
      )
    )
  )
  (
    (lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else
            (add 1 (length (cdr l)))
          )
        )
      )
    )
    (
      (lambda (length)
        (lambda (l)
          (cond
            ((null? l) 0)
            (else
              (add 1 (length (cdr l)))
            )
          )
        )
      )
    eternity
    )
  )
)
```

### Close, but there are still repetitions.
Let's get rid of them

### Where should we start?
Naming the function that takes `length` as an argument and returns a function that looks like `length`

###  What's a good name for this function?
`mk-length`

### Okay, do this to `length0`
```
(
  (lambda (mk-length)
    (mk-length eternity)
  )
  (lambda (length)
    (cond
      ((null? l) 0)
      (else
        (add1 (length (cdr l)))
      )
    )
  )
)
```

### Is this `length1?`
```
(
  (lambda (mk-length)
    (mk-length
      (mk-length eternity)))
  (lambda (length)
    (lambda (l)
    (cond
      ((null?l) 0)
      (else (add1 (length (cdr l))))))))
```
Yup

### Can you write `length3` in this style?
```
(
  (lambda (mk-length)
    (mk-length
      (mk-length
        (mk-length
          (mk-length eternity)
        )
      )
    )
  )
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (add1 (length (cdr l)))
      )
    )
  )
)
```

### What is recursion like?
It is like an infinite tower of applications of `mk-length` to an arbitrary function.

### Do we really need an infinite tower?
Not really of course. Everytime we use length we only need a finite number, but we never know how many.

### Could we guess how many we need?
Sure, but we may not guess a large enough number.

### When do we find out that we didn't guess a large enough number?
When we apply the function `eternity` that is passed to the innermost `mk-length`.

### What if we could create another application of mk-length to eternity at this point?
That would only postpone the problem by one, and besides, how could we do that?

### Well, since nobody cares what function we pass to `mk-length` we could pass it `mk-length` initially.
That's the right idea.
And then we invoke `mk-length` on eternity and the result of this on the `cdr`
so that we get one more piece of the tower.

### Then is this still `length0`
```
(
  (lambda (mk-length)
    (mk-length mk-length))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else
          (add1 (length (cdr l)))
        )
      )
    )
  )
)
```
Yes, we could even use `mk-length` instead of `length`.

### Now that `mk-length` is passed to `mk-length` can we use the argument to create an additional recursive use?
Yes, when we apply `mk-length` once, we get `length1`
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else
          (add1 ((mk-length eternity) (cdr l))
        )
      )
    )
  )
)
```

### What is the value of
```
(
  (
    (lambda (mk-length)
      (mk-length mk-length)
    )
    (lambda (mk-length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else
            (add1 ((mk-length eternity) (cdr l)))
          )
        )
      )
    )
  )
  l
)
```
### where `l` is (apples)
1

### Could we do this more than once?
Yup, we could do it infinite times

### What would you call this function?
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else
          (add1 ((mk-length mk-length) (cdr l))))))))
```
It's `length`

### How does it work?
It keeps passing `mk-length` to itself until `l` is the empty list.

### One problem is left: it no longer contains the function that looks like length
### `(add1 (*(mk-length mk-length)* (cdr l)))`
We could extract this new application of `mk-length` to itself and call it `length`.
Like this,
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (
      (lambda (length)
        (lambda (l)
          (cond
            ((null? l) 0)
            (else
              (add1 (length (cdr l)))
            )
          )
        )
      )
    )
    (mk-lenght mk-length)
  )
)
```

### What is the value of
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (
      (lambda (length)
        (lambda (l)
          (cond
            ((null? l) 0)
            (else
              (add1 (length (cdr l)))
            )
          )
        )
      )
    )
    (mk-lenght mk-length)
  )
)
```
### where `l` is (apples)
It should be 1

### First need the value of
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (
      (lambda (length)
        (lambda (l)
          (cond
            ((null? l) 0)
            (else
              (add1 (length (cdr l)))
            )
          )
        )
      )
    )
    (lambda (mk-length)
      (
        (lambda (length)
          (lambda (l)
            (cond
              ((null? l) 0)
              (else
                (add1 (length (cdrl l)))
              )
            )
          )
        )
      )
      (mk-length mk-length)
    )
  )
)
```
### since that is the value with the result of `(mk-length mk-length)`
Makes sense

### So we really need to know the value of
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (
      (lambda (length)
        (lambda (l)
          (cond
            ((null? l) 0)
            (else
              (add1 (length (cdr l)))
            )
          )
        )
      )
    )
    (lambda (mk-length)
      (
        (lambda (length)
          (lambda (l)
            (cond
              ((null? l) 0)
              (else
                (add1 (length (cdrl l)))
              )
            )
          )
        )
      )
        (lambda (mk-length)
          (
            (lambda (length)
              (lambda (l)
                (cond
                  ((null? l) 0)
                  (else
                    (add1 (length (cdrl l)))
                  )
                )
              )
            )
          )
        (mk-length mk-length)
      )
    )
  )
)
```
It seems it will never end...

### Yes, there is no end to it. Why?
Because the definition needs to take into account that the list can be infinite
so we just keep applying `mk-length` to itself again and again and again ...

### Is this strange?
A bit.
It is because mk-length used to return a function when we applied it to an argument.
Indeed, it didn't matter what we applied it to.

### But now that we have extracted `(mk-length mk-length)` from the function that makes `length`
### it does not return a function anymore.
No it doesn't. So what do we do?

### Turn the application of `mk-length` to itself in our last correct version of `length` into a function:
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else
          (add1 ((mk-length mk-length) (cdr l))))))))
```
How?

### Here is a different way. If `f` is a function of one argument, is `(lambda (x) (f x))` a function of one argument?
Yep

### If `(mk-length mk-length)` returns a function of one argument, does
```
(lambda (x)
  ((mk-length mk-length) x))
```
### return a function of one argument?
Yes, actually, `(lambda (x) ((mk-length mk-length) x))` is a function!

### Okay, let's do this to the application of `mk-length` to itself.
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else
          (add1
            (
              (lambda (x) ((mk-length mk-length) x))
              (cdr l))))))))
```

### Move out the new function so that we get length back.
```
(
  (lambda (mk-length)
    (mk-length mk-length)
  )
  (lambda (mk-length)
    (lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else
            (add1 (length (cdr l))))))))
  (lambda (x) ((mk-length mk-length) x))
)
```

### Can we extract the innermost function in that looks like `length` and give it a name?
Yes, it does not depend on `mk-length` at all!

### Is this the right function?
```
((lambda (le)
  ((lambda (mk-length)
    (mk-length mk-length))
  (lambda (mk-length)
    (le (lambda (x)
          ((mk-length mk-length) x))))))
(lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l))))))))
```
I guess

### What did we actually get back?
We extracted the original function `mk-length`.

### Let's separate the function that makes `length` from the function that looks like `length`
```
(lambda (le)
  ((lambda (mk-length)
    (mk-length mk-length))
  (lambda (mk-length)
    (le (lambda (x)
          ((mk-length mk-length) x))))))
```

### Does this function have a name?
Yes, it is called the applicative-order `Y` combinator.
```
(define Y
  (lambda (le)
    (
      (lambda (f) (f f))
      (lambda (f)
        (le (lambda (x) ((f f) x)))
      )
    )
  )
)
```

### Does (define ... ) work again
Sure, now that we know what recursion is.

### Do you now know why `Y` works?
Read this chapter again and you will
