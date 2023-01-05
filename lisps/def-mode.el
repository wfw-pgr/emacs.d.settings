
;;; ------------------------------------------------------------------------- ;;;
;;;   def-mode       to edit .def parameter variables definition file         ;;;
;;; ------------------------------------------------------------------------- ;;;

(require 'generic-x) ;; we need this

(defface font-lock-operator
  '((t (:foreground "cyan1")))
  "face of volume in MML for PMD")

(defface font-lock-operator2
  '((t (:foreground "green")))
  "face of volume in MML for PMD")

(define-generic-mode 
    'def-mode                       ;; name of the mode to create
  '("$$")                           ;; comments start with '!!'
  kw_list                           ;; some keywords
  '(("=" . 'font-lock-operator)     ;; '=' is an operator
    ("#" . 'font-lock-operator)
    ("@" . 'font-lock-operator)
    ("$" . 'font-lock-operator)
    ("(" . 'font-lock-operator2)
    (")" . 'font-lock-operator2)
    
    )                               ;; ';' is a built-in 
  '("\\.def$")                      ;; files for which to activate this mode 
  (setq-default tab-width 4 indent-tabs-mode nil) ;; other functions to call
  "A mode for .dev files"           ;; doc string for this mode
  )

(setq kw_list '( "<define>" "<include>" "<postProcess>" ))

(provide 'def-mode)
