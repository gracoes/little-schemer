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

(define operator
  (lambda (aexp)
    (car aexp)
  )
)

(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))
  )
)
(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))
  )
)

(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp) '+)
        (+ (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp)))
      )
      ((eq? (operator nexp) 'x)
        (x (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp)))
      )
      (else
        (expt (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp)))
      )
    )
  )
)

(define sero?
  (lambda (n)
    (null? n)
  )
)

(define edd1
  (lambda (n)
    (cons '() n)
  )
)

(define zub1
  (lambda (n)
    (cdr n)
  )
)

(define myedd
  (lambda n1 n2
    (cond
      ((sero? n2) n1)
      (else
        (edd1 (myedd n1 (zub1 n2)))
      )
    )
  )
)
