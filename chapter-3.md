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

### What is the value of `(rember a lat)` where `a` is and and `lat` is (bacon lettuce and tomato)
`(bacon lettuce tomato)`