### What is `(rember a lat)` where `a` is mint and `lat` is `(lamb chops and mint jelly)`
`(lamb chops and jelly)`

### What is `(rember a lat)` where `a` is mint and `lat` is `(lamb chops and mint flavored mint jelly)`
`(lamb chops and flavored mint jelly)`

### `(rember a lat)` where `a` is toast and `lat` is (bacon lettuce and tomato)
`(bacon lettuce and tomato)`

### `(rember a lat)` where `a` is cup and `lat` is (coffee cup tea cup and hick cup)
`(coffee tea cup and hick cup)`

### What does (rember a lat) do?
Removes the first occurrence o `a` in `lat`, returning the list without `a`

### What steps should we use to do this?
1. See if `lat` is `null`, if yes return the empty list
2. See if `a` is equal to `(car lat)`, if yes join the elements before `a` with `(cdr lat)`
3. If `a` not equal to `(car lat)` return `(cons (car lat) (rember a (cdr lat)))`

### And if (null? lat) is true?
Return an empty list

### What do we know if (null? lat) is not true?
We know `lat` is not empty

### Is there any other question we should ask about the `lat`?
No. Either a lat is empty or it contains at least one atom.

### What do we do if we know that the `lat` contains at least one atom?
Ask more questions

### How do we ask questions?
`cond`

### How do we ask if a is the same as (car lat)
`(eq? a (car lat))`

### What would be the value of `(rember a lat)` if `a` were the same as `(car lat)`
`(cdr lat)`

### What do we do if `a` is not the same as `(car lat)`
Ask if `a` exists in the rest of `lat`

### How do we remove the first occurrence of `a` in the rest of `lat`
We call `(rember a (cdr lat))`

### Is there any other question we should ask?
`else`

### Now, let's write down what we have so far:
```
(define rember
	(lambda (a lat)
		(cond
			((null? lat) ('()))
			(else (cond
					((eq? (car lat) a) (cdr lat))
					(else (rember a
							(cdr lat))))))))
```
### What is the value of `(rember a lat)` where `a` is bacon and `lat` is (bacon lettuce and tomato)
`(lettuce and tomato)`

### Now, let's see if this function works. What is the first question?
`(null? lat)`

### What do we do now?
Ask another question, else

### What next?
`(eq? (car lat) a)`

### (eq? (car lat) a)
Yes

### Is this the correct value?
Yes

### But did we really use a good example?
No

### What does rember do?
Removes the first occurrence of `a` in `lat` by returning `lat` without `a`

### What do we do now?
We compare each atom of the lat with the
atom a, and if the comparison fails we build
a list that begins with the atom we just
compared.

### What is the value of `(rember a lat)` where `a` is `and` and `lat` is (bacon lettuce and tomato)
`(bacon lettuce tomato)`

###  Let us see if our function `rember` works. What is the first question asked by `rember`?
`(null? lat)`

### What do we do now?
`lat` is not null so we ask the next question, `else`

### `(eq? (car lat) a)`
No

### What is the meaning of `(else (rember a (cdr lat))`
Return the result of calling `rember` on the rest of `lat` -> `(rember 'and '(lettuce and tomato)`

### `(null? lat)`
No

### `(eq? (car lat) a)`
`(eq? 'lettuce 'and)` -> False

### What is the meaning of `(rember a (cdr lat))`
Call `rember` on the rest of `lat` -> `(rember 'and '(and tomato))`

### `(null? lat)`
No

### (eq? (car lat) a)
`(eq? 'and 'and)` -> True

### So what is the result?
`'(tomato)`

### Is this correct?
No

### What did we do wrong?
We didn't save all the atoms that were not `a`

### How can we keep from losing the atoms `bacon` and `lettuce`
We use `cons` to build lists

### Let's see what happens when we use `cons`
```
(define rember
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat)
              (rember a (cdr lat)))))))

```

### What is the value of `(rember a lat)` where `a` is `and` and `lat` is `(bacon lettuce and tomato)`
`'(bacon lettuce tomato)`

###  What is `(firsts l)` where `l` is ((apple peach pumpkin) (plum pear cherry) (grape raisin pea) (bean carrot eggplant))
`(apple plum grape bean)`

### What is `(firsts l)` where `l` is ((a b) (c d) (e f))
`(a c e)`

### What is `(firsts l)` where `l` is ()
`()`

### What is `(firsts l)` where `l` is ((five plums) (four) (eleven green oranges))
`(five four eleven)`

### What is `(firsts l)` where `l` is (((five plums) four) (eleven green oranges) ((no) more))
`((five plums) eleven (no))``

### In your own words, what does `(firsts l)` do?
`firsts` takes a list `l` where every element is a list.
It builds another list containing the first S-expression of each list.

### See if you can write the function `firsts`. Remember the Commandments!
(define firsts
  (lambda l
    (cond
      ((null? l) '())
      (else (cons (car l) (firsts (cdr l)))))))

###  Keeping in mind the definition of `(firsts l)` what is a typical element of the value of `(firsts l)`
### where `l` is ((a b) (c d) (e f))
`a`

### What is another typical element?
`e`

### Consider the function `seconds`.
### What would be a typical element of the value of (seconds l) where `l` is ((a b) (c d) (e f))
`d`

### How do we describe a typical element for (firsts l)
It's the first S-expression in one of `l` internal lists.

### When we find a typical element of (firsts l) what do we do with it?
We `cons` into our returning list.

###  What does (firsts l) do
```
(define firsts
  (lambda (l)
    (cond
      ((null? l) ...)
      (else (cons (car (car l))
              (firsts (cdr l)))))))
```
### where l is ((a b) (c d) (e f))
It returns the list `(a c e)`

### What do we need to `cons` atoms onto?
A list

### For the purpose of consing, what value can we give when (null? l) is true?
The empty list, `()`

### With `() as a value, we now have three cons steps to go back and pick up. We need to:
### I. either
###      1. cons e onto ()
###      2. cons c onto the value of 1
###      3. cons a onto the value of 2
### II. or
###      1. cons a onto the value of 2
###      2. cons c onto the value of 3
###      3. cons e onto ()
### III. or
###      cons a onto
###      the cons of c onto the cons of e onto
###      ()
### In any case, what is the value of (firsts l)
`(a c e)`

###  With which of the three alternatives do you feel most comfortable?
I

### What is (insertR new old lat) where `new` is `topping` `old` is `fudge` and `lat` is (ice cream with fudge for dessert)
`(ice cream with fudge topping for desert)`

### (insertR new old lat) where `new` is `jalapeno` `old` is `and` and lat is (tacos tamales and salsa)
`(tacos tamales and jalapeno salsa)`

### (insertR new old lat) where `new` is `e` `old` is `d` and lat is (a b c d f g d h)
`(a b c d e f g h)`

### In your own words, what does `(insertR new old lat)` do?
insertR receives 3 arguments, 2 atoms (`new` and `old`) an a list of atoms `lat`, and builds a list with
all the elements of `lat` and adding `new` to the right of `old`.

### See if you can write the first three lines of the function `insertR`
```
(define insertR
  (lambda (new old lat)
    (cond ...)))
```

### Which argument changes when we recur with `insertR``
`lat`

### How many questions can we ask about the lat?
Two.
A lat is either the null list or a non-empty list of atoms.

### Which questions do we ask?
First, we ask `(null? lat)`.
Second, we ask `else`, because `else` is always the last question.

### What do we know if (null? lat) is not true?
That `lat` is not an empty list

### Which questions do we ask about the first element?
If it is equal to `old` => `(eq? (car lat) old)`

###  Now see if you can write the whole function `insertR`
```
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      (else
        (cond
          ((eq? (car lat) old)
            (cons
              old
              (cons new (cdr lat))))
          (else
            (cons
              (car lat)
              (insertR new old (cdr lat))))
        )
      )
    )
  )
)
```

### Now try insertL
### Hint: insertL inserts the atom `new` to the left of the first occurrence of the atom `old` in `lat``
(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      (else
        (cond
          ((eq? (car lat) old)
            (cons new lat)
          (else
            (cons
              (car lat)
              (insertL new old (cdr lat)))
          )
        )
      )
    )
  )
)

### Now try `subst`
### Hint: (subst new old lat) replaces the first occurrence of `old` in the lat with `new`.
### For example, where new is topping old is fudge and lat is (ice cream with fudge for dessert)
### the value is (ice cream with topping for dessert).
### Now you have the idea.
(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      (else
        (cond
          ((eq? (car lat) old)
            (cons new (cdr lat)))
          (else
            (cons
              (car lat)
              (subst new old (cdr lat))
          )
        )
      )
    )
  )
)

### Now try `subst2`
### Hint: (subst2 new o1 o2 lat) replaces either the first occurrence of o1 or the first occurrence of o2 by `new`
### For example, where new is vanilla o1 is chocolate o2 is banana and `lat` is (banana ice cream with chocolate topping)
### the value is (vanilla ice cream with chocolate topping)
(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) '())
      (else
        (cond
          ((or
            (eq? (car lat) o1)
            (eq? (car lat) o2))
              (cons new (cdr lat)))
          (else
            (cons
              (car lat)
              (subst2 new o1 o2 (cdr lat))
            )
          )
        )
      )
    )
  )
)

















