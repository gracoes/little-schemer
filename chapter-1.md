## Atoms
### Is this an atom?
1. `atom` -> Yes
2. `turkey` -> Yes
3. `1492` -> Yes
4. `u` -> Yes
5. `*abc$` -> Yes

## Lists
### Is this a list?
1. `(atom)` -> Yes
2. `(atom turkey or)` -> Yes
3. `(atom turkey) or` -> No
4. `((atom turkey) or)` -> Yes

## S-expressions
### Is this a S-expression
1. `xyz` -> Yes
2. `(x y z)` -> Yes
3. `((x y) z)` -> Yes
### How many S-expressions are in the list and what are they
1. `(how are you doing so far)` -> 6: `how` `are` `you` `doing` `so` `far`
2. `(((how) are) ((you) (doing so)) far)` -> 3: `((how) are)` `((you) (doing so))` `far`

### Is `()` a list?
Yes

### Is `()` an atom?
No

### Is `( () () () )` a list?
Yes

## Car
### What is the `car` of `l` when `l` is
1. `(a b c)` -> `a`
2. `((a b c) x y z)` -> `(a b c)`
3. `hotdog` -> Error, `hotdog` is not a list
4. `()` -> Error, `()` is an empty list
5. `(((hotdogs)) (and) (pickle) relish)` -> `((hotdogs))`
### What is `(car (car l))` where l is `(((hotdogs)) (and))`?
`(hotdogs)`

## Cdr
### What is the `cdr` of `l` when `l` is
1. `(a b c)` -> `(b c)`
2. `((a b c) x y z)` -> `(x y z)`
3. `(hamburger)` -> `()`
4. `((x) tr)` -> `(t r)`
5. `hotdogs` -> Error, cannot apply `cdr` to an atom
6. `()` -> Error, cannot apply `cdr` to an empty list

## Car and Cdr
### What is `(car (cdr l))`, where `l` is `((b) (x y) ((c)))`
`(x y)`
### What is `(cdr (cdr l))`, where `l` is `((b) (x y) ((c)))`
`(((c)))`
### What is `(cdr (car l))` where `l` is `(a (b (c)) d)`
Error, cannot apply `cdr` to the atom `a`

### What does `car` takes as an argument?
A non-empty list

### What does `cdr` takes as an argument?
A non-empty list

## Cons
### What is the `cons` of the atom `a` and the list `l` where `a` is peanut and `l` is `(butter and jelly)`?
`(peanut butter and jelly)`
### What is the `cons` of `s` and `l` where `s` is `(banana and)` and `1` is `(peanut butter and jelly)`
`((banana and) peanut butter and jelly)`
### What is `(cons s l)` where `s` is `((help) this)` and `1` is `(is very ((hard) to learn))`
`(((help) this) is very ((hard) to learn))`
### What does cons take as its arguments?
An S-expression and a list
### What is `(cons s l)` where `s` is `(a b (c))` and `l`is `()`
`((a b (c)))`
### What is `(cons s l)` where `s` is `a` and `l` is `()`
`(a)`
### What is `(cons s l)` where `s` is `a` and `l` is `b`
Error, the second argument of `cons` must be a list