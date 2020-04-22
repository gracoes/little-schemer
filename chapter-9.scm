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
