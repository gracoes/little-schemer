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

(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else
        (myadd
          (car tup)
          (addtup (cdr tup))
        )
      )
    )
  )
)

(define x
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else
        (myadd
          n
          (x n (sub1 m))
        )
      )
    )
  )
)

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else
        (cons
          (myadd (car tup1) (car tup2))
          (tup+ (cdr tup1) (cdr tup2))
        )
      )
    )
  )
)

(define >
  (lambda (n m)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else
        (> (sub1 n) (sub1 m))
      )
    )
  )
)

(define <
  (lambda (n m)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
      (else
        (< (sub1 n) (sub1 m))
      )
    )
  )
)

(define =
  (lambda (n m)
    (cond
      ((> n m) #f)
      ((< n m) #f)
      (else #t)
    )
  )
)

(define expt
  (lambda (n m)
    (cond
      ((zero? n) 0)
      ((zero? m) 1)
      (else
        (x n (expt n (sub1 m)))
      )
    )
  )
)

(define quotient
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else
        (add1 (quotient (- n m) m))
      )
    )
  )
)

(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else
        (add1 (length (cdr lat)))
      )
    )
  )
)

(define pick
  (lambda (n lat)
    (cond
      ((null? lat) '())
      ((zero? (sub1 n)) (car lat))
      (else
        (pick (sub1 n) (cdr lat))
      )
    )
  )
)

(define rempick
  (lambda (n lat)
    (cond
      ((null? lat) '())
      ((zero? (sub1 n)) (cdr lat))
      (else
        (cons
          (car lat)
          (rempick (sub1 n) (cdr lat))
        )
      )
    )
  )
)
