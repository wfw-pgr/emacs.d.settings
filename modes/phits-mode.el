
;;; ------------------------------------------------------------------------- ;;;
;;;   phits-mode       to edit PHITS's parameter.inp file                     ;;;
;;; ------------------------------------------------------------------------- ;;;

(require 'generic-x) ;; we need this

(defface font-lock-operator3
  '((t (:foreground "cyan1"))) "Comment:: Font faces for marks" )

(defface font-lock-operator4
  '((t (:foreground "green"))) "Comment:: Font faces for (), []"    )


(define-generic-mode 'phits-mode      ;; name of the mode to create
  '("$$")                             ;; comments start with '!!'
  kw_list_phits_mode                  ;; some keywords
  '(("="   . 'font-lock-operator3)    ;; '=' is an operator
    ("#"   . 'font-lock-operator3)
    ("@"   . 'font-lock-operator3)
    ("\\$" . 'font-lock-operator3)    ;;  use \\ for escape sequence
    ("\\[" . 'font-lock-operator4)
    ("\\]" . 'font-lock-operator4)
    ("("   . 'font-lock-operator4)
    (")"   . 'font-lock-operator4)
    )   ;; ';' is a built-in
  ;;
  '("_phits\\.inp$")                  ;; files for which to activate this mode 
  (setq-default tab-width 4 indent-tabs-mode nil) ;; other functions to call
  "A mode for PHITS files"            ;; doc string for this mode
  )

(setq kw_list_phits_mode '("set" "surface" "Surface" "Title" "title" "Parameters" "parameters"
			   "Source" "source" "Material" "material" "MatNameColor" "matnamecolor"
			   "Transform" "transform" "cell" "Cell" "importance" "Importance"
			   "Volume" "volume" "Multiplier" "multiplier" "END" "End" "end" 
			   "photon" "electron" "proton" "neutron" "T-Deposit"
			   "t-deposit" "T-Point" "t-point" "T-Gshow" "t-gshow"
			   "T-Track" "t-track" "T-Product" "t-product" "T-Cross" "t-cross"
			   "T-DChain" "T-Dchain" "T-DCHAIN" "t-dchain"
			   "<define>" "<include>" "<postProcess>" "<loadJSON>" "filepath" ))


(provide 'phits-mode)
