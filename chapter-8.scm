(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a)
    )
  )
)

(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else
          (cons
            (car l)
            ((rember-f test?) a (cdr l))))))))

(define insert-g
  (lambda (seq)
    (lambda (new old l)
      (cond
        ((null? l) '())
        ((eq? (car l) old)
          (seq new old (cdr l)))
        (else
          (cons
            (car l)
            ((insert-g seq) new old (cdr l))
          )
        )
      )
    )
  )
)

(define insertL
  (insert-g
    (lambda (new old l)
      (cons new (cons old l))
    )
  )
)

(define atom-to-function
  (lambda (atom)
    (cond
      ((eq? atom '+) +)
      ((eq? atom 'x) x)
      (else expt)
    )
  )
)

(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
        ((atom-to-function (operator nexp))
          (value (1st-sub-exp nexp))
          (value (2nd-sub-exp nexp)))
      )
    )
  )
)

