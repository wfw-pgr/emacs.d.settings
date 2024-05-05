;;; ========================================================================= ;;;
;;;   Json-mode ( .sif )       to edit .sif parameter files in Json         ;;;
;;; ========================================================================= ;;;
;; see https://uid0130.blogspot.com/2014/05/emacsgeneric-mode.html 

;; ------------------------------------------------------------------- ;;
;; ---  [1]   call generic-x mode.                                 --- ;;
;; ------------------------------------------------------------------- ;;
(require 'generic-x)

;; ------------------------------------------------------------------- ;;
;; ---  [2] リストインターリーブ関数の定義                          -- ;;
;; ------------------------------------------------------------------- ;;
(defun list-interleave (ls res inserting)
  (cond
   ((not ls)  (reverse res))
   ((not res) (list-interleave (cdr ls) (cons (car ls) res) inserting))
   (t (list-interleave
       (cdr ls)
       (cons (car ls) (cons inserting res))
       inserting))))

;; ------------------------------------------------------------------- ;;
;; ---  [3] リストインターリーブ関数を使用したキーワード群の定義    -- ;;
;; ------------------------------------------------------------------- ;;
;; -- 変数型群01 -- ;;
(defvar json-type-keywords01
  (apply 'concat (list-interleave
                  '("true" "false" "null")
                  '() "\\|")))

;; --  演算子群01 -- ;;
(defvar json-operator-keywords01
  (apply 'concat (list-interleave
                  '(":" "{" "}")
                  '() "\\|")))
;; --  演算子群02 -- ;;
(defvar json-operator-keywords02
  (apply 'concat (list-interleave
		  '("@.+" "$.+" )
                  '() "\\|")))

;; ------------------------------------- ;;
;; --- [2]   define font-lock face   --- ;;
;; ------------------------------------- ;;
(defface font-lock-type01
  '((t (:foreground "green")))  "Comment:: Font faces for bool"       )

(defface font-lock-operator01
  '((t (:foreground "orange"))) "Comment:: Font faces for operator01" )

(defface font-lock-operator02
  '((t (:foreground "blue1")))  "Comment:: Font faces for operator02" )

(define-generic-mode 'json-mode    ;; name of the mode to create
  '("//" )                         ;; comments start with '!!'
  kw_list_json_mode                ;; Main Highlights. Defined as below ( must be unique name. )
  `(                               ;; back-quatation is needed here !!!!
    ;; Detailed Highlights..
    (,json-type-keywords01     . 'font-lock-type01    )
    (,json-operator-keywords01 . 'font-lock-operator01)
    (,json-operator-keywords02 . 'font-lock-operator02)
    )
  '( "\\.json$" )                    ;; files for which to activate this mode 
  (setq-default tab-width 2 indent-tabs-mode nil) ;; other functions to call
  "A mode for json files"     ;; doc string for this mode
  )

(setq kw_list_json_mode '("json" ) )

(provide 'json-mode)
