(define new-entry build)

(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
     ((null? names) (entry-f name))
     ((eq? name (car names))
      (car values))
     (else
      (lookup-in-entry-help name (cdr names) (cdr values) entry-f)
     )
    )
  )
)

(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help
      name
      (first entry)
      (second entry)
      entry-f)))

(define lookup-in-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else
        (lookup-in-entry
          name
          (car table)
          (lambda (name)
            (lookup-in-table name (cdr table) table-f)
          )
        )
      )
    )
  )
)

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

(define *quote
  (lambda (e table)
    (text-of e)
  )
)

(define text-of second)

(define initial-table
  (lambda (name)
    (car '())))

(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))

(define *lambda
  (lambda (e table)
    (build (quote non-primitive) (cons table (cdr e)))))

(define initial-table
  (lambda (name)
    (car (quote ()))))

(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)
  ))

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

(define :atom?
  (lambda (x)
    (cond
      ((null? x) #f)
      ((atom? x) #t)
      ((eq? (car x) 'primitive) #t)
      ((eq? (car x) 'non-primitive) #t)
      (else #f))))

(define apply-primitive
  (lambda (name vals)
    (cond
      ((eq? name 'cons)
        (cons (first vals) (second vals)))
      ((eq? name 'car)
        (car (first vals)))
      ((eq? name 'cdr)
        (cdr (first vals)))
      ((eq? name 'null?)
        (null? (first vals)))
      ((eq? name 'eq?)
        (eq? (first vals) (second vals)))
      ((eq? name ':atom?)
        (atom? (first vals)))
      ((eq? name 'zero?)
        (zero? (first vals)))
      ((eq? name 'add1)
        (add1 (first vals)))
      ((eq? name 'sub1)
        (sub1 (first vals)))
      ((eq? name 'number?)
        (number? (first vals)))
    )
  )
)

(define apply
  (lambda (f args)
    (cond
      ((primitive? f)
        (apply-primitive (second f) args))
      ((non-primitive? f)
        (apply-closure (second f) args))
    )
  )
)

(define function-of car)

(define arguments-of cdr)

(define evlis
  (lambda (l table)
    (cond
      ((null? l) '())
      (else
        (cons
          (meaning (car l) table)
          (evlis (cdr l) table))
      )
    )
  )
)

(define *application
  (lambda (e table)
    (apply
      (meaning (function-of e) table)
      (evlis (arguments-of e) table))))

(define table-of
  (lambda (e)
    (car (e))
  )
)

(define formals-of
  (lambda (e)
    (car (cdr e))
  )
)

(define body-of
  (lambda (e)
    (car (cdr (cdr e)))
  )
)
