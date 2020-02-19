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

### What is `(cons s (car l))` where `s` is `a` and `l` is ((b) c d)
`(a b)`

### What is `(cons s (cdr l))` where `s` is `a` and `l` is `((b) c d)`
`(a c d)`

### Is it true that the list `l` is the `null` list where l is `()`
Yes

### What is `(null? (quote ()))`
True

### Is `(null? l)` `true` or `false` where `l` is `(a b c)`
False

### Is `(null? a)` `true` or `false` where `a` is `spaghetti`
No answer, you cannot ask `null?` of an atom

## atom?
### Is it `true` or `false` that `s` is an atom where `s` is `Harry`
True

### Is `(atom? s)` `true` or `false` where `s` is `Harry`
True

### Is `(atom? s)` `true` or `false` where `s` is `(Harry had a heap of apples)`
False

### How many arguments does `atom?` take and what are they?
`atom?` takes a S-Expression as the single argument

### Is `(atom? (car l))` `true` or `false` where `l` is `(Harry had a heap of apples)`
True

### Is `(atom? (cdr l))` `true` or `false` where `l` is `(Harry had a heap of apples)`
False

### Is `(atom? (cdr l))` `true` or `false` where `l` is `(Harry)`
False

### Is `(atom? (car (cdr l)))` `true` or `false` where `l` is `(swing low sweet cherry oat)
True, `(car (cdr l))` => `low`

### Is `(atom? (car (cdr l)))` `true` or `false` where `l` is `(swing (low sweet)cherry oat)
False, `(car (cdr l))` => `(low sweet)`

## Eq?
### Is `(eq? a1 a2)` `true` or `false` where `a1` is `Harry` and `a2` is `Harry`
True

### Is `(eq? a1 a2)` `true` or `false` where `a1` is `margarine` and `a2` is `butter`
False

### How many arguments does eq? take and what are they?
`eq?` takes 2 non-numeric atoms as arguments

### Is `(eq? l1 l2)` `true` or `false` where `l1` is `()` and `l2` is `(strawberry)`
No answer, since `l1` and `l2` are lists

### Is `(eq? n1 n2)` `true` or `false` where `n1` is `6` and `n2` is `7`
No answer since `n1` and `n2` are numbers

### Is `(eq? (car l) a)` `true` or `false` where `l` is `(Mary had a little lamb chop)` and `a` is `Mary`
True

### Is `(eq? (cdr l) a)` `true` or `false` where `l` is `(soured milk)` and `a` is  `milk`
No answer, because `(cdr l)` => `(milk)` != `milk`

### Is `(eq? (car l) (car (cdr l)))` `true` or `false` where `l` is `(beans beans we need jelly beans)`
True, `(car l)` => `beans` and `(car (cdr l))` => `beans`
