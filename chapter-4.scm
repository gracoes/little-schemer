(define add1
  (lambda (n)
    (+ n 1)
  )
)

(define sub1
  (lambda (n)
    (- n 1)
  )
)

(define myadd
  (lambda (n1 n2)
    (cond
      ((zero? n2) n1)
      (else
        (myadd (add1 n1) (sub1 n2))
      )
    )
  )
)

(define mysub
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else
        (mysub (sub1 n) (sub1 m))
      )
    )
  )
)
