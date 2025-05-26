
;; ======================================== ;;
;; =====          init.el            ====== ;;
;; ======================================== ;;

;; -------------------------------- ;;
;; ---  [1]  Package include    --- ;;
;; -------------------------------- ;;
;;
;; ---   proxy  --- ;;
;; (setq url-proxy-services
;;       '(("http"  . "http://proxy.intra.co.jp:8080")
;;         ("https" . "http://proxy.intra.co.jp:8080"))
;;       )
;;
;; --- packages --- ;;
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; --------------------------------- ;;
;; ---  [2] call init-loader     --- ;;
;; --------------------------------- ;;

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

