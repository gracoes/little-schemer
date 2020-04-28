### An entry is a pair of lists whose first list is a set.
### Also, the two lists must be of equal length.
### Make up some examples for entries.
`((1 2 3 4) (apple banana pear grape))`

### How can we build an entry from a set of names and a list of values?
`(define new-entry-build)`
Try to build our examples with this function

### What is `(lookup-in-entry name entry)` where `name` is entree and
### `entry` is ((appetizer entree beverage) (food tastes good))
`tastes`

### What if `name` is dessert
In this case we would like to leave the decision about what to do with the user of `lookup-in-entry`.

### How can we accomplish this?
By having `lookup-in-entry` receive an extra argument that is invoked when
`name` is not found in the first list of an entry.

### How many arguments do you think this extra function should take?
One, `name`

###  Here is our definition of lookup-in-entry
```
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help
      name
      (first entry)
      (second entry)
      entry-f)))
```
### Finish the function lookup-in-entry-help
```
(define lookup-in-entry-help
  (lambda (name names values entry-f
    (cond
     ((null? names) (entry-f name))
     ((eq? name (car name))
      (car values))
     (else
      (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
     )
    )
  )
)
```

### A table (also called an environment) is a list of entries.
### Here is one example: the empty table, represented by ()
### Make up some others.
`(((1 2 3) (banana apple pear)) ((appetizer entree desert) (bread pizza pie)))`


### Define the function `extend-table` which takes an entry and a table (possibly the empty one)
### and creates a new table by putting the new entry in front of the old table.
`(define extend-table cons)` (`extend-table` is an alias for `cons`)

### What is `(lookup-in-table name table table-f)` where `name` is entree
### `table` is (((entree dessert) (spaghetti spumoni)) ((appetizer entree beverage) (food tastes good)))
### and `table-f` is (lambda (name) ...)
It could be either spaghetti or tastes, but `lookup-in-table` searches the list of entries in order. So it is spaghetti.

### Write lookup-in-table
### Hint: Don't forget to get some help.
```
(define lookup-in-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else
        (lookup-in-entry
          name
          (car table)
          (lambda (name)
            (lookup-in-table name (cdr table) table-f)
          )
        )
      )
    )
  )
)
```

### Can you describe what the following function represents:
```
(lambda (name)
  (lookup-in-table name (cdr table) table-f))
```
The continuation of the search for `name` in `table` if it's not found in `car` of `table`

### In the preface we mentioned that sans serif typeface would be used to represent atoms.
### To this point it has not mattered. Henceforth, you must notice whether or not an atom is in sans serif.
Remember to be very conscious as to whether or not an atom is in sans serif.

### Have we chosen a good representation for expressions?
Yes. They are all S-expressions so they can be data for functions.

### What kind of functions?
For example, `value`

### Do you remember `value` from chapter 6?
Recall that `value` is the function that returns the natural value of expressions.

### What is the value of `(car '(a b c))`
We don't even know what `'(a b c)` is.

###  What is the value of
```
(cons rep-a
  (cons rep-b
    (cons rep-c
      '())))
```
### where `rep-a` is a `rep-b` is b and `rep-c` is c
(a b c)

### Great. And what is the value of
```
(cons
  rep-car
  (cons
    (cons
      rep-quote
      (cons
        (cons rep-a
          (cons rep-b
            (cons rep-c
              '())))
        '()))
   '()
  )
)
```
### where `rep-car` is car, `rep-quote` is quote, `rep-a` is a, `rep-b` is b and `rep-c` is c
It is a representation of the expression: (car '(a b c)).

### What is the value of (car (quote (a b c)))
a

### What is (value e) where `e` is (car (quote (a b c)))
a

### What is (value e) where `e` is (quote (car (quote (a b c))))
(car '(a b c))
