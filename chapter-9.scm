(define keep-looking
  (lambda (a s lat)
    (cond
      ((number? s)
        (keep-looking a (pick s lat) lat))
      (else
        (eq? s a)
      )
    )
  )
)

(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))

(define shift
  (lambda (pair)
    (build
      (first (first pair))
      (build
        (second (first pair))
        (second pair)))
  )
)

(define length*
  (lambda (l)
    (cond
      ((null? l) 0)
      ((atom? (car l)) (add1 (length* (cdr l))))
      (else
        (+ (length* (car l)) (length* (cdr l)))
      )
    )
  )
)

(define shuffle
  (lambda (pora)
    (cond
      ((a-pair? (first pora))
        (shuffle (revpair pora)))
      (else
        (build (first pora) (shuffle (second pora)))))))

(define C
  (lambda (n)
    (cond
      ((one? n) 1)
      (else
        (cond
          ((even? n) (C (/ n 2)))
          (else
            (C (add1 (x 3 n)))))))))

(define A
  (lambda (n m)
    (cond
    ((zero? n) (add1 m))
    ((zero? m) (A (sub1 n) 1))
    (else
      (A (sub1 n)
        (A n (sub1 m)))))))

(define will-stop?
  (lambda (f)
    (cond
      ((f '()) #t)
      (else #f)
    )
  )
)

(define last-try
  (lambda (x)
    (and (will-stop? last-try) (eternity x))))
