#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (myEven n)
  (if (= 0 (modulo n 2))
      true
      false
  )
)

(define (myFactorial n)
  (if (= n 0)
      1
      (* n (myFactorial (- n 1)))
   )
)

(define (mySum start end)
  (if (= start end)
      start
      (+ start (mySum (+ 1 start) end))
   )
)

(define (fastPow n x)
  (define (square y)
    (* y y))
  
  (if (= 0 x)
      1
      (if (= 1 (modulo x 2))
          (* n (square (fastPow n (quotient x 2))))
          (square (fastPow n (quotient x 2)))
      )
  )
)

(define (prime? n)
  (define (helper start end n)
    (if (= start end)
      true
      (if (= 0 (modulo n start))
          false
          (helper (+ start 1) end n)
       )
     )
   )

  (helper 2 (+ 1 (quotient n 2)) n)
)

(define (count-digits n)
  (if (= n 0)
      0
      (+ 1 (count-digits (quotient n 10)))
  )
)

(define (sum-digits n)
  (if (= n 0)
      0
      (+
       (modulo n 10)
       (sum-digits (quotient n 10))
      )
  )
)

(define (automorphic? n)
  (define (getModulo x)
    (if (= x 1)
        1
        (* 10 (getModulo (- x 1)))
    )
  )

  (define (numberIterate number root mod)
    (if (= mod 1)
        false
        (if (= root (modulo number mod))
            true
            (numberIterate (modulo number mod) root (quotient mod 10))
        )
     )
  )

  (if (= n 1)
      true
      (numberIterate (* n n) n (getModulo (count-digits (* n n))))
  )
)             

;==========================================================================================================================================================

(define (myReverse new old)
  (if (empty? old)
      new
      (myReverse (cons (car old) new) (cdr old))
  )
)

(define (palindromeList? n)
  (if (equal? n (myReverse '() n))
      true
      false
  )
)

;==========================================================================================================================================================


(define (numberReverse new old)
  (if (= old 0)
      new
      (numberReverse (+ (* new 10) (modulo old 10)) (quotient old 10))
   )
)

(define (palindrome? n)
  (= n (numberReverse 0 n))
)

;==========================================================================================================================================================
(define (createList a b)
  (if (> a b)
      '()
      (cons a (createList (+ a 1) b))
  )
)

(define (count-numbers-task n curr)
  (if (= n 0)
    curr
    (if (= n (sum-digits n))
      (count-numbers-task (- n 1) (+ curr 1))
      (count-numbers-task (- n 1) curr)
    )
  )
)
      
(define (count-palindromes a b)
  (length (filter palindrome? (createList a b)))
)

(define (sum-del n)
  (define (del? x)
    (= 0 (modulo n x))
  )
  (foldl + 0 (filter del? (createList 1 n)))
)

(define (hasPrime? a b)
  (empty? (filter prime? (createList a b)))
)

(define (del? n x)
    (= 0 (modulo n x))
)

(define (accumulate function null-value list)
  (if (empty? list)
      null-value
      (function (car list) (accumulate function null-value (cdr list)))
  )
)

(define (factorial n)
  (accumulate * 1 (createList 1 n))
)

(define (pow x n)
  (accumulate * 1 (my-map (λ(number) x) (createList 1 n)))
)

(define (var k n)
  (/ (factorial n) (factorial (- n k)))
)
;==========================================================================================================================================================

(define (merge a b)
  (cond
    [(empty? a) b]
    [(empty? b) a]
    [(< (car a) (car b)) (cons (car a) (merge (cdr a) b))]
    [else (cons (car b) (merge a (cdr b)))]
  )
)

(define (merge-sort a)
  (define (split a it list1 list2)
    (cond 
      [(empty? a) (cons list1 (list list2))]
      [(even? it)(split (cdr a) (+ it 1) (cons (car a) list1) list2)]
      [else (split (cdr a) (+ it 1) list1 (cons (car a) list2))]
     )
  )
  
  (if (<= (length a) 1)
      a
      (apply merge (map merge-sort (split a 0 '() '())))
  )
)

;(merge-sort '(19 2 3 4 1 939 13 1 23))
;==========================================================================================================================================================
(define (my-length my-list)
  (if (empty? my-list)
      0
      (+ 1 (my-length (cdr my-list)))
  )
)

(define my-list '(1 2 3 (4 5) (6 (7 8))))

(define get-1 (car my-list))
(define get-2 (car (cdr my-list)))
(define get-3 (car (cdr (cdr my-list))))
(define get-4 (car (car (cdr (cdr (cdr my-list))))))
(define get-5 (car (cdr (car (cdr (cdr (cdr my-list)))))))
(define get-6 (car (car (cdr (cdr (cdr (cdr my-list)))))))
(define get-7 (car (car (cdr (car (cdr (cdr (cdr (cdr my-list)))))))))
(define get-8 (car (cdr (car (cdr (car (cdr (cdr (cdr (cdr my-list))))))))))

(define (my-map function my-list)
  (if (empty? my-list)
      '()
      (cons (function (car my-list)) (my-map function (cdr my-list)))
  )
)

(define (member? element my-list)
  (cond
   [(empty? my-list) false]
   [(= element (car my-list)) true]
   [else (member? element (cdr my-list))]
  )
)


(define (my-filter function my-list)
  (cond
   [(empty? my-list) '()]
   [(function (car my-list)) (cons (car my-list) (my-filter function (cdr my-list)))]
   [else (my-filter function (cdr my-list))]
  )
)

(define (zip list1 list2)
  (cond
    [(empty? list1) '()]
    [(empty? list2) '()]
    [else (cons (cons (car list1) (list (car list2))) (zip (cdr list1) (cdr list2)))]
  )
)

(define (zipwith function list1 list2)
  (cond
    [(empty? list1) '()]
    [(empty? list2) '()]
    [else (cons (function (car list1) (car list2)) (zipwith function (cdr list1) (cdr list2)))]
  )
)

(define (slice my-list start end)
  (cond
    [(empty? my-list) '()]
    [(< end start) '()]
    [(< end 0) '()]
    [(> start 0) (slice (cdr my-list) (- start 1) (- end 1))]
    [(= start 0) (cons (car my-list) (slice (cdr my-list) start (- end 1)))]
  )
)

(define (flatten my-list)
  (cond
    [(empty? my-list) '()]
    [(list? (car my-list)) (append (flatten (car my-list)) (flatten (cdr my-list)))]
    [else (cons (car my-list) (flatten (cdr my-list)))]
  )
)

(define (take my-list num)
  (cond
    [(empty? my-list) '()]
    [(< num 1) '()]
    [else (cons (car my-list) (take (cdr my-list) (- num 1)))]
  )
)

(define (drop my-list num)
  (cond
    [(empty? my-list) '()]
    [(< num 1) my-list]
    [else (drop (cdr my-list) (- num 1))]
  )
)

(define (my-min my-list)
  (cond
    [(empty? (cdr my-list)) (car my-list)]
    [else (min (car my-list) (my-min (cdr my-list)))]
  )
)

(define (my-max my-list)
  (cond
    [(empty? (cdr my-list)) (car my-list)]
    [else (max (car my-list) (my-max (cdr my-list)))]
  )
)

(define (any? my-list function)
  (cond
    [(empty? my-list) false]
    [(function (car my-list)) true]
    [else (any? (cdr my-list) function)]
  )
)

(define (all? my-list function)
  (cond
    [(empty? my-list) true]
    [(equal? (function (car my-list)) false) false]
    [else (all? (cdr my-list) function)]
  )
)

(define (compose function x num)
  (if (= num 1)
      (function x)
      (function (compose function x (- num 1)))
  )
)

(define (nth-col my-list n)
  (define (get-nth lst n)
    (cond
      [(empty? lst) '()]
      [(= n 1) (car lst)]
      [else (get-nth (cdr lst) (- n 1))]
    )
  )
  
  (if (empty? my-list)
      '()
      (cons (get-nth (car my-list) n) (nth-col (cdr my-list) n))
  )
)

(define (transpose my-list)
  (if (empty? my-list)
      '()
      '()
  )
)

