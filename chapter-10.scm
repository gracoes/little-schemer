(define atom-to-action
  (lambda (a)
    (cond
      ((number? a) *const)
      ((or (eq? a #t) (eq? a #f)) *const)
      ((eq? a 'cons) *const)
      ((eq? a 'car) *const)
      ((eq? a 'cdr) *const)
      ((eq? a 'null?) *const)
      ((eq? a 'eq?) *const)
      ((eq? a 'atom?) *const)
      ((eq? a 'zero?) *const)
      ((eq? a 'add1?) *const)
      ((eq? a 'sub1?) *const)
      ((eq? a 'number?) *const)
      (else *identifier)
    )
  )
)

(define list-to-action
  (lambda (l)
    (cond
      ((atom? (car l))
        (cond
          ((eq? (car l) 'quote) *quote)
          ((eq? (car l) 'lambda) *lambda)
          ((eq? (car l) 'cond) *cond)
          (else *application)
        )
      )
      (else *application)
    )
  )
)

(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else
        (list-to-action e)
      )
    )
  )
)

(define value
  (lambda (e)
    (meaning e (quote ()))))

(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

(define *const
  (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      (else (build (quote primitive) e)))))

(define else?
  (lambda (e)
    (cond
      ((atom? e) (eq? e 'else))
      (else #f)
    )
  )
)

(define question-of
  (lambda (line)
    (car line)
  )
)

(define answer-of
  (lambda (line)
    (car (cdr line))
  )
)

(define evcon
  (lambda (lines table)
    (cond
      ((else? (question-of (car lines)))
        (meaning (answer-of (car lines)) table)
      )
      ((meaning (question-of (car lines)) table)
        (meaning (answer-of (car lines)) table)
      )
      (else (evcon (cdr lines) table)))))

(define cond-lines-of cdr)

(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)
  )
)

(define primitive?
  (lambda (l)
    (eq? (first l) 'primitive)
  )
)

(define non-primitive?
  (lambda (l)
    (eq? (first l) 'non-primitive)
  )
)

(define apply
  (lambda (f args)
    (cond
      ((primitive? f)
        (apply-primitive (second f) args)
      ((non-primitive? f)
        (apply-closure (second f) args))
    )
  )
)

(define function-of car)

(define arguments-of cdr)

(define *application
  (lambda (e table)
    (apply
      (meaning (function-of e) table)
      (evlis (arguments-of e) table))))
