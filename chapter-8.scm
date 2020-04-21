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

(define multirember-f
  (lambda (test?)
    (lambda (a lat)
      (cond
        ((null? lat) '())
        ((test? (car lat) a)
          ((multirember-f test?) a (cdr lat)))
        (else
          (cons
            (car lat)
            ((multirember-f test?) a (cdr lat)))
        )
      )
    )
  )
)

(define multirember&co
  (lambda (a lat col)
    (cond
      ((null? lat)
        (col '() '()))
      ((eq? (car lat) a)
        (multirember&co
          a
          (cdr lat)
          (lambda (newlat seen)
            (col
              newlat
              (cons (car lat) seen)))))
      (else
        (multirember&co
          a
          (cdr lat)
          (lambda (newlat seen)
            (col
              (cons (car lat) newlat)
              seen)))))))

(define multiinsertLR
  (lambda (new oldR oldL lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) oldL)
        (cons
          new
          (cons oldL (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? (car lat) oldR)
        (cons
          oldR
          (cons new (multiinsertLR new oldL oldR (cdr lat))))
      )
      (else
        (cons
          (car lat)
          (multiinsertLR new oldL oldR (cdr lat)))
      )
    )
  )
)

(define multiinsertLR&co
  (lambda (new oldL oldR lat col)
    (cond
      ((null? lat) (col '() 0 0)
      ((eq? (car lat) oldL)
        (multiinsertLR&co new oldL oldR (cdr lat)
          (lambda (newlat L R)
            (col (cons new (cons oldL newlat)) (add1 L) R))))
      ((eq? (car lat) oldR)
        (multiinsertLR&co new oldL oldR (cdr lat)
          (lambda (newlat L R)
            (col (cons oldR (cons new newlat) L (add1 R))))))
      (else
        (multiinsertLR&co new oldL oldR (cdr lat)
          (lambda (newlat L R)
            (col (cons (car lat) newlat) L R))))))))
