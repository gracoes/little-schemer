###  What is `(rember* a l)` where `a` is cup and `l` is ((coffee) cup ((tea) cup) (and (hick)) cup)
### "rember*" is pronounced "rember-star."
`((coffee) ((tea)) (and (hick)))`

### What is `(rember* a l)` where `a` is sauce and `l` is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
`(((tomato)) ((bean)) (and ((flying))))`

### Now write `rember*`
```
(define rember*
  (lambda (a l)
    (cond
      ((null? l) '())
      ((atom? (car l))
        (cond
          ((eq? (car l) a)
            (rember* a (cdr l)))
          (else
            (cons
              (car l)
              (rember* a (cdr l))
            )
          )
        )
      )
      (else
        (cons
          (rember* a (car l))
          (rember* a (cdr l))
        )
      )
    )
  )
)
```

### `(lat? l)` where `l` is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
False

###  Is `(car l)` an atom where `l` is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))
False
