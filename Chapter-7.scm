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

(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2) (subset? set2 set1))
  )
)


(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1) #f)
      (else
        (or
          (member? (car set1) set2)
          (intersect? (cdr set1) set2)
        )
      )
    )
  )
)

(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2)
        (cons (car set1) (intersect (cdr set1) set2))
      )
      (else
        (intersect (cdr set1) set2)
      )
    )
  )
)

(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2)
        (union (cdr set1) set2))
      (else
        (cons
          (car set1)
          (union (cdr set1) set2)
        )
      )
    )
  )
)

(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set)) (car l-set))
      (else
        (intersect (car l-set) (intersectall (cdr l-set)))
      )
    )
  )
)
