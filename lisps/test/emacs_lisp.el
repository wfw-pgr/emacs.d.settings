

;;; -------------------------------------------------------------------------- ;;;
;;; ---   emacs lisp test                                                  --- ;;;
;;; -------------------------------------------------------------------------- ;;;

;;; =================================== ;;;
;;; press  [ C-x C-e ]
;;;  to evaluate the line ( from left-end to the position of the cursor )
;;; =================================== ;;;

;;;
;;; < atoms >
;;;

3.14159265358979

;;;
;;; < calculation >
;;;
(+ 1 2)
(* (- 10 5) (+ 2 3) )
fill-column                 ;; = 70
(* fill-column 2)           ;; = 140

;;;
;;; < string >
;;;
(message "Hello world!!")
(message (if ( > NUM 0) "NUM is larger than 0" "NUM is less than 0" ) )

;;;
;;;  < function / list >
;;;
(1 2 3 4 5)                ;; 1 is not function -> Error      1. function at first
'(1 2 3 4 5)               ;; symbolic-expression -> OK       2. suppress to treat the statement as function

;;;
;;;  < setq :: substituition >
;;;
(setq x 1)
(setq x 1 y 2)

;;;
;;;  < if >
;;;
(setq NUM -10)
(message (if ( > NUM 0) "NUM is larger than 0" "NUM is less than 0" ) )


;;;
;;;  < define function >
;;;
(defun myfunction(x)
  "my original function"
  (interactive "p")
  (message "x = %d" x)
  )
(setq x 1)
(myfunction x)

;;;
;;;  < function "function" to evaluate symbolic-expression >
;;;
(defun text-mode-message () (message "begin text-mode") )
(add-hook 'text-mode-hook 'text-mode-message)

(defun text-mode-message () (message "begin text-mode") )
(add-hook (function text-mode-hook) (function text-mode-message))

(defun text-mode-message () (message "begin text-mode") )
(add-hook #'text-mode-hook #'text-mode-message)

;; same meanings....

;;;
;;; quote
;;;
(setq mylist (quote (1 2 3) ) )
(setq mylist '(1 2 3) )

;;;
;;; cons cell 
;;;
(cons 101 (cons 102 (cons 103 nil) ) )
(cons "hello" 2)
(car '("a" "b" "c") )
(cdr '("a" "b" "c") )
(cdr (cdr '("a" "b" "c") ) )
