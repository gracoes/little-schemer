(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      (else
        (and
          (not (member? (car lat) (cdr lat)))
          (set? (cdr lat))
        )
      )
    )
  )
)

(define make-set
  (lambda (lat)
    (cond
      ((null? lat) '())
      (else
        (cons
          (car lat)
          (make-set
            (multirember (car lat) (make-set (cdr lat))))
        )
      )
    )
  )
)

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else
        (and
          (member? (car set1) set2)
          (subset? (cdr set1) set2))
      )
    )
  )
)
