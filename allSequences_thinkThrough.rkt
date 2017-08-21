;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname allSequences_thinkThrough) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Given a list of items of arbitrary length, produce all possible sequences
;; of arbitrary length n. For example if you are given the list,
;; (list "Rock" "Paper" "Scissors" "Car"), and you want to produce
;; all sequences of length 2. You would need to produce
;; (list
;;  (list "Rock" "Rock")
;;  (list "Rock" "Paper")
;;  (list "Rock" "Scissors")
;;  (list "Rock" "Car")
;;  (list "Paper" "Rock")
;;  (list "Paper" "Paper")
;;  (list "Paper" "Scissors")
;;  (list "Paper" "Car")
;;  (list "Scissors" "Rock")
;;  (list "Scissors" "Paper")
;;  (list "Scissors" "Scissors")
;;  (list "Scissors" "Car")
;;  (list "Car" "Rock")
;;  (list "Car" "Paper")
;;  (list "Car" "Scissors")
;;  (list "Car" "Car"))

;; We abstract away "Rock", "Paper", "Scissors" to any arbitary type,
;; for instance we could use numbers instead. Therefore, we use ListOf(X).
;; ListOf(X) could represent ListOf(String) or ListOf(Natural) 

;; The function that we will write is called all-sequences. We will use the
;; design methods from the book, "How to Design Programs." We need to
;; first define what the inputs are and the outputs:

;; all-sequences
;; Signature: ListOf X, Natural -> ListOf(ListOf X)
;; Purpose: produce all the possible n-length sequences of elements in lox

;; We need to define a Stub so that we can make sure our tests are
;; well formed, and we understand our return type.

;; This stub is tricky? Why? 

;; It is tricky because your initial thought is to set the
;; stub to return empty, as this is typical. However, here
;; you have to carefully see that the return type in the
;; signature/contract is ListOf(ListOfX). This means that
;; the stub needs to return back
;; this type,
;; for it to be well-defined. 

;;Stub:
#;
(define (all-sequences lox n)
  (list empty))

;; We use the type Naturals to write out our tests. 

(check-expect (all-sequences (list 0 1) 3) 
              (list (list 0 0 0) 
                    (list 0 0 1)
                    (list 0 1 0) 
                    (list 0 1 1)
                    (list 1 0 0) 
                    (list 1 0 1)
                    (list 1 1 0) 
                    (list 1 1 1)))


;; It is hard to get intuituion of how the problem works from
;; the above tests. We need something more basic.

;; Basic tests:
(check-expect (all-sequences (list 0 1) 0)
              (list empty)) ;; another example of understanding
                            ;; the return type in the signature

;; test 3:
(check-expect (all-sequences (list 0 1) 1)
              (list (list 0) (list 1)))

;; test 4:
(check-expect (all-sequences (list 0 1) 2)
              (list (list 0 0) (list 0 1) (list 1 0) (list 1 1)))

;; test 3 and 4, help our intution. It seems like what test 4 is doing,
;; is taking the two lists in created in test 3. And then adding another
;; element to each of those lists. For example, we see that test 4 is
;; taking (list 0) from test 3, and making it into (list 0 0), (list 0 1).
;; Essentially, the bigger problem, test 4 is using the smaller problem,
;; test 3. 


;; How are we going to write this function?

;; This is where we are going to use Type Comments
;; and Data Driven Templates to figure out what to do. 

;; Let's define our data. We have ListOf(X) and n
;; as our inputs.

;; ListOf(X) is one of:
;; - empty
;; - (cons X (rest ListOf(X)))

;; n is a natural number, and we are going to define natural numbers as
;; a linked list, to help us reason about the states that we can be in.
;; For example, we can defined a linked list starting at 
;; 5 as 5->4->3->2->1->0. Here 0 represents the end of the list. 
;; And we were counting down from some arbitrary positive
;; number to zero, we could define our natural numbers as 

;; NaturalNumbers is one of:
;; - 0   - this is like 0 in the 5->4->3->2->1->0
;; - (cons Natural (rest NaturalNumbers)), this is like writing 5 and (4->3->2->1->0)


;; Great, now we have type comments, how are we going to write this function?


;; Let's recap what we have. 

;; Well we can see from the tests especially with the n =1
;; and n =2 that for every iteration, of n
;; we are "kind of inserting" into the list created
;; by the previous n, i.e. when n=2, 
;; we look at the result from the test of n=1, and see
;; what changed. When we have n=2
;; we take each number from lox and add it to all
;; the lists from the result of n=1. 

;; If we think about it, we have two one-of types.
;; ListOfX and Natural(i.e. n).
;; Given these two inputs. Do we need to worry about how
;; they interact? 

;; If they interact, then we have to use those two type comments
;; and create a table that maps their interaction. 

;; But for them to interact, we have to have both of LOX and
;; n to be changing. Are they both changing? We need to check
;; the examples. 

;; We can look back at our examples and we see that lox is not
;; changing even when we change n= 1 or n=2 or n=3. The only things
;; changing is how many times you need to insert, which is represented
;; by n. (this is clear if you look at all three tests)


;; ListOfX is not changing and so we only need to create a 
;; data-driven template off of Natural Numbers. 

;; Therefore, we need to template this question to Natural Numbers
;; NaturalNumbers is one of:
;; - 0
;; - (cons Natural (rest NaturalNumbers))

;; We need to convert this Type Comment into a Data-Driven
;; Template.

;; How do we do this. Well, first notice that
;; (rest NaturalNumbers) is a smaller version of NaturalNumbers
;; From our example of 5->4->3->2->1->0.
;; (rest NaturalNumbers) would be 4->3->2->1->0, which is a
;; smaller version of our problem.

;; So if I wanted a funtion on Natural Numbers, I could
;; slowly convert my type comment into a function.

;; Let's use the word fn to represent a name of an arbitrary
;; function so if we add fn in front of every time we see
;; NaturalNumbesr we can write

;; fn(NaturalNumbers) is one of:
;; - 0
;; - (cons Natural fn(rest NaturalNumbers))

;; if we now make the "-" if statements,
;; where we represent with dots ... to
;; state that we don't know what to return from the if
;; conditions, but we need to use the things around the dots.

;; fn(NaturalNumbers) is one of:
;; if (NaturalNumbers) is 0 (do ...)
;; else do something with ...Natural... fn(rest NaturalNumbers))

;; replace NaturalNumbers with n

;; fn(n) is one of:
;; if (n==0) (do ...)
;; else ( do something with n... fn(rest n))

;; But the rest of n is like saying the list you get
;; from subtracting one from n, (sub 1)

;; so we have:
;; fn(n) is one of:
;; if (n==0) (do ...)
;; else ( do something with n... fn(sub1 n))

;; let's take away some of the english language from above
;; function fn(n){
;;     if (n==0) return (...)
;;     else (... n... fn(sub1 n))}

;; remember dots represent, we need to do something here, with the
;; things that surround the dots.

;; Since lox does not vary, but is a parameter, we add it to
;; function definition and everywhere we see dots, except at
;; if n equals 0, because 0 is a special state.

;; function fn(lox, n){
;;     if (n==0) return (...)
;;     else (...lox...n... fn(lox, sub1 n))}


;; Now you have taken a data definition for natual numbers
;; and created a data-driven template. Notice how
;; we have recursion in our else case. The recursion
;; works because fn(lox, sub1 n) is a smaller problem
;; than fn(lox n). The case where n=0 is our base case.

;; Above we used some
;; weird hybrid notation to make the transition from
;; a data definition to a data-driven template.
;; We need to go back to our LISP family of notation. 

;; The template in Racket notation will then be:

#;
(define (all-sequences lox n)
  (cond [(zero? n) (...)]
        [else (...lox
               n
               (all-sequences lox (sub1 n)))]))


;; Remember, I said 0 is kind of weird so,
;; how do we know what to put in the (...)
;; near (zero? n)?

;; We use our examples/tests to figure out what
;; to do. When we look at a our test when n=0
;; we see that we need to return (list empty)
;; so we add this to the template:


#;
(define (all-sequences lox n)
  (cond [(zero? n) (list empty)]
        [else (...lox
               n
               (all-sequences lox (sub1 n)))]))

;; now we need to figure out what to do in the
;; else case/the recursive case. The recursive
;; call in the else case is called, the Natural Recursion.
;; This recursion is the naturally was created from our data
;; definition. 


;; We need to now fill in the dots. This is where the deep
;; thinking happens.

;; We are going to now use our examples/tests to figure out
;; how to fill in the dots in
;; the recursive case for our data-driven template.

;; We are going to reason about what we have. And then
;; we are going to write a few more functions to fill out
;; the dots in our template. We will then apply these new function
;; in lew of the dots. 


;; We can pick an example where we are working with the case
;; where n = 3.

;; So how do we think about this?
;; Well, we can assume that the Natural Recursion (also
;; known as the Induction Hypothesis or "Friend"), i.e.
;; the recursive call in our template,
;; is giving us the solution to
;; the smaller problem of when n=2


;; In the case of three elements,
;; we know that the natural recursion is
;; giving back all possible sequences of size two.
;; so we have
;; lox => (list 0 1)
;; n => 3
;; and from Natural Recursion:
;; (list (list 0 0) (list 0 1) (list 1 0) (list 1 1))

;; What do we need to do in this combine step?

;; In our example for n=3, we need to
;; add 0 to the "returned" natural recursion created list,
;; and separately, we need to add 1 to the same natural
;; recursion's resulting list. Once we have both of these,
;; take both and combine them, and return one
;; unified ListOF(listOfX).

;; Given that we have to do this for each element
;; of LOX, we can write a function
;; that takes an element and inserts it into a ListOf(ListOfX).
;; Another way to think about this is take an
;; element from lox insert it into llox creating a new llox.
;; And after I write this function, I need to
;; apply this function
;; for every element in lox. 


;; insert: X, ListOf(ListOf(X)) -> ListOfListOfX
;; Purpose: add X onto ListOf(ListOfX)
;; Examples and Tests:
(check-expect (insert 1 (list (list 0) (list 1)))
                           (list (list 1 0) (list 1 1)))
;;Stub:
#;
(define (insert x llox)
  (list empty))

;; How are we going to template this?
;; X does not change here. We need to move
;; through ListOf(ListOf(X))
;; ListOf(ListOfX) is compound data so the
;; template should be
#;
(define (fn-for-llox x llox)
  (cond [(empty? llox) (...)]
        [else (...(fn-for-lox (first llox))
                  (fn-for-llox (rest llox)))]))

;; We use fn-for-llox to stand for a generic function
;; that processes llox. Note that since each element of
;; List(ListOf(X)) is a list, i.e. if you have (list (list 1) (list 2))
;; then both elements of this list our lists too. Therefore,
;; you may need another function to process this list. Hence,
;; in the above template you see fn-for-lox, which is standing in
;; for a generic function that could process a list. Since ListOf(ListOf(X))
;; is made up of other lists, it is a type of compound data. 

;; adding some detail to the template:
#;
(define (insert x llox)
  (cond [(empty? llox) (...)]
        [else (...x (fn-for-lox (first llox))
                    (insert (rest llox)))]))

;; for fn-for-lox, all we need to do is cons x onto
;; (first llox) so
;; we can just write it as

#;
(define (insert x llox)
  (cond [(empty? llox) (...)]
        [else (... (cons x (first llox))
                   (insert x (rest llox)))]))

;; What do we do with the ... in the else statement?

;; we can fill the ... in the else statement with cons b/c
;; the natural recursion is giving us back a ListOf(ListOF(X))
;; with the solution already done for all the remaining cases.
;; For example: in the check expect above for insert,
;; the natural recursion is giving us (list (list 1 1))
;; and using our (cons x (first llox) is giving back (list 0 1)
;; what do we need to do?
;; We can also think of the natural
;; recursion as (list Y), and our processing
;; of the first element is giving us Y.
;; Therefore, we need to cons this Y onto (list Y).
 

;; We know have:
#; 
(define (insert x llox)
  (cond [(empty? llox) (...)]
        [else (cons (cons x (first llox))
                    (insert x (rest llox)))]))


;; What do we do with the (...) in the first cond clause? 

;; I naturally thought I need to
;; add ListOf(empty) as this is the return type
;; my tests failed.

;; You need to return empty. Why?

;; If you think about it when the
;; natural recursion hits the end past the last element
;; in our list, what do we need to give back?
;; If we tried to send back (list empty)
;; then we would be trying to cons a
;; llox onto (list empty) b/c (list empty) would be
;; the result of the natural recursion, and that doesn't make sense
;; you can only cons llox onto empty.

;; We know have:
(define (insert x llox)
  (cond [(empty? llox) empty]
        [else (cons (cons x (first llox))
                    (insert x (rest llox)))]))


;; we now need to run insert on every element in lox,
;; we will get a number of resulting lists and we
;; can combine them.

;; this where they used append map
;; map take three arguments here:
;; 1. the function
;; 2. the list to process
;; 3. the list to insert into.

;; Signature: (X, LLOX -> LLOX), LOX LLOX -> LLOX
;; (we use parathesis ( -> ) to represent functions as
;; arguments. 
;; Purpose: to apply function to every element of LOX
;; Stub:
#;
(define (map-append fn lox llox)
  (list empty))

;; Again how are we going to template this?
;; Well the lox is the only thing changing so
;; we can template on the ListOfX that we defined earlier. 

#;
(define (map-append fn lox llox)
  (cond [(empty? lox) empty]
        [else (append (fn (first lox) llox)
                      (map-append fn (rest lox) llox))]))

;; we are going to use insert
;; as our fn in map-append when we are ready.

;; But first we can add these functions locally. 

;; we can add map-append and insert as local into our template

(define (all-sequences lox n)
  (local [(define (insert x llox)
            (cond [(empty? llox) empty]
                  [else (cons (cons x (first llox))
                              (insert x (rest llox)))]))
          (define (map-append fn lox llox)
            (cond [(empty? lox) empty]
                  [else (append (fn (first lox) llox)
                                (map-append fn (rest lox) llox))]))
          ]
  (cond [(zero? n) (list empty)]
        [else (map-append insert lox (all-sequences lox (sub1 n)))])))

;; If you run this file, all our tests pass!! 