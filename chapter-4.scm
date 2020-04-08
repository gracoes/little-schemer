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

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat)) (no-nums (cdr lat)))
      (else
        (cons
          (car lat)
            (no-nums (cdr lat))
        )
      )
    )
  )
)

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat))
        (cons
          (car lat)
          (all-nums (cdr lat))
        )
      )
      (else
        (all-nums (cdr lat))
      )
    )
  )
)

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (= a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else
        (eq? a1 a2)
      )
    )
  )
)

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? (car lat) a)
        (add1 (occur a (cdr lat)))
      )
      (else
        (occur a (cdr lat))
      )
    )
  )
)

(define one?
  (lambda (n)
    (= 1 n)
  )
)

(define rempick2
  (lambda (n lat)
    (cond
      ((null? lat) '())
      ((one? n) (cdr lat))
      (else
        (cons
          (car lat)
          (rempick2 (sub1 n) (cdr lat))
        )
      )
    )
  )
)
