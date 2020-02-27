## lat

### True or false: `(lat? l)` where `l` is `(Jack Sprat could eat no chicken fat)`
True

### True or false: `(lat? l)` where `l` is `((Jack) Sprat could eat no chicken fat)`
False

### True or false: `(lat? l)` where `l` is `(Jack (Sprat could) eat no chicken fat)`
False

### True or false: `(lat? l)` where `l` is `()`
False

### True or false: a lat is a list of atoms.
True

### How do we determine the answer `#t` for the application `(lat? l)`
If `l` is null or if every element is an atom

### What is the first question asked by `(lat? l)`
Is `l` null?

### What is the meaning of the cond-line `((null? l) #t)` where `l` is `(bacon and eggs)`
False

### What is the next question?
If the first element of `l` is an atom

### What is the meaning of the line `((atom? (car l)) (lat? (cdr l)))` where `l` is `(bacon and eggs)`
`(atom? (car l))` asks if the first element of `l` is an atom, if `#t` it asks if the
rest of `l` is a list of atoms `(lat? (cdr l))`

### What is the meaning of `(lat? (cdr l))`
Is the rest of the list `l` a list of atoms?

### Now what is the argument l for lat?
The rest of the list `l`

### What is the next question?
Is `l` null?

### What is the meaning of the line `(( null? l) #t)` where `l` is now `(and eggs)`
If `l` is null return `true`

### What is the next question?
`((atom? (car l))`

### What is the meaning of the line `((atom? (car l)) (lat? (cdr l)))` where `l` is `(and eggs)`
Ask if the firs element of `l` is an atom and if true asks if the rest of `l` is a list of atoms

### What is the meaning of `(lat? (cdr l))`
Is the rest of `l` (`(eggs)`) a list of atoms?

### Can you describe what the function lat? does in your own words?
`lat?` is a function that takes a list of S-expressions as an argument and checks if that list is a list of atoms by asking if every element of the list is an atom

### What is the value of `(lat? l)` where 'l` is now `(bacon (and eggs))`
False

### Can you describe how we determined the value `#f` for `(lat? l)` where `l` is `(bacon (and eggs))`
We called `atom?` for each element of `l` and since `(and eggs)` is not an atom, `l` is not a list of atoms

### Is `(or (null? l1) (atom? l2))` true or false where `l1` is () and `l2` is `(d e f g)`
True, `l1` is the empty list and `l2` is a list of atoms

### Is `(or (null? l1) (null? l2))` true or false where `l1` is () and `l2` is `(d e f g)`
True

### Is `(or (null? l1) (null? l2))` true or false where `l1` is (a b c) and `l2` is `(atom)`
False, both `l1` and `l2` are list of atoms


### What does (or ... ) do?
`(or ...)` asks two boolean questions and returns `true` when one or both of them are true and returns `false` when both of them are `false`

## member?
```
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
      (member? a (cdr lat)))))))
```
### Is it true or false that a is a member of lat where a is tea and lat is (coffee tea or milk)
True

### Is `(member? a lat)` true or false where a is poached and lat is (fried eggs and scrambled eggs)
False

# What is the value of (member? a lat) where a is meat and lat is (mashed potatoes and meat gravy)
True

### What is the meaning of the line `((null? lat) #f)` where lat is (mashed potatoes and meat gravy)
If `lat` is the empty list return false

### What is the next question?
`(else (or (eq? (car lat) a)))`

### Why is else the next question?
Because `lat` is not null

## Is else really a question?
Yes, `else` is a question whose value is always true

### What is the meaning of the line
```
(else (or (eq? (car lat) a) 
        (member? a (cdr lat))))
```
Asks if the first element of `lat` is equal to `a`, if not call `member?` on the rest of `lat`


### True or false:
```
(or (eq? (car lat) a)
    (member? a (cdr lat)))
``` 
### where a is meat and lat is (mashed potatoes and meat gravy)
True





