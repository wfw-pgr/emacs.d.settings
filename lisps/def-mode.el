
;;; ------------------------------------------------------------------------- ;;;
;;;   def-mode       to edit .def parameter variables definition file         ;;;
;;; ------------------------------------------------------------------------- ;;;

;; ------------------------------------- ;;
;; --- [1]   call generic-x mode.    --- ;;
;; ------------------------------------- ;;
(require 'generic-x)

;; ------------------------------------- ;;
;; --- [2]   define font-lock face   --- ;;
;; ------------------------------------- ;;
(defface font-lock-operator1
  '((t (:foreground "cyan1"))) "Comment:: Font faces for marks" )

(defface font-lock-operator2
  '((t (:foreground "green"))) "Comment:: Font faces for ()"    )

(define-generic-mode 'def-mode      ;; name of the mode to create
  '("$$")                           ;; comments start with '!!'
  kw_list_def_mode                  ;; defined as below ( must be unique name. )
  '(("="   . 'font-lock-operator1)  ;; '=' is an operator
    ("#"   . 'font-lock-operator1)
    ("@"   . 'font-lock-operator1)
    ("("   . 'font-lock-operator2)
    (")"   . 'font-lock-operator2)
    ("\\$" . 'font-lock-operator1)  ;;  use \\ for escape sequence
    ("\\[" . 'font-lock-operator2)
    ("\\]" . 'font-lock-operator2)
    )  ;; ';' is a built-in 
  '("\\.def$")                      ;; files for which to activate this mode 
  (setq-default tab-width 4 indent-tabs-mode nil) ;; other functions to call
  "A mode for .dev files"           ;; doc string for this mode
  )

(setq kw_list_def_mode '( "<define>" "<include>" "<postProcess>" "filepath" ))

(provide 'def-mode)
