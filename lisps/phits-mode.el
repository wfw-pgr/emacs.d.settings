
;;; ------------------------------------------------------------------------- ;;;
;;;   phits-mode       to edit PHITS's parameter.inp file                     ;;;
;;; ------------------------------------------------------------------------- ;;;

(require 'generic-x) ;; we need this

(defface font-lock-operator
  '((t (:foreground "cyan1")))
  "face of volume in MML for PMD")

(defface font-lock-operator2
  '((t (:foreground "green")))
  "font color for parencess")

(define-generic-mode 
    'phits-mode                       ;; name of the mode to create
  '("$$")                             ;; comments start with '!!'
  kw_list                             ;; some keywords
  '(("=" . 'font-lock-operator)       ;; '=' is an operator
    ("#" . 'font-lock-operator)
    ("@" . 'font-lock-operator)
    ("$" . 'font-lock-operator)
    ("(" . 'font-lock-operator2)
    (")" . 'font-lock-operator2)

    )                                 ;; ';' is a built-in 
  '("_phits\\.inp$")                  ;; files for which to activate this mode 
  (setq-default tab-width 4 indent-tabs-mode nil) ;; other functions to call
  "A mode for PHITS files"          ;; doc string for this mode
  )

(setq kw_list '("set" "surface" "Surface" "Title" "title" "Parameters" "parameters"
		"Source" "source" "Material" "material" "MatNameColor" "matnamecolor"
		"Transform" "transform" "cell" "Cell" "importance" "Importance"
		"Volume" "volume" "Multiplier" "multiplier" "END" "End" "end" 
		"photon" "electron" "proton" "neutron" "T-Deposit" "t-deposit" "T-Point" "t-point" 
		"T-Gshow" "t-gshow" "T-Track" "t-track" "T-Product" "t-product" "T-Cross" "t-cross"
		"T-DChain" "T-Dchain" "T-DCHAIN" "t-dchain" ))

(provide 'phits-mode)
