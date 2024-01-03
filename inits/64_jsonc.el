;; -----------------------------------------;;
;; | For json with commend mode            |;;
;; -----------------------------------------;;
;; 拡張子の*.rst, *.restのファイルをrst-modeで開く
(setq auto-mode-alist
      (append '(("\\.json$" . javascript-mode)
		("\\.jsonc$" . javascript-mode)) auto-mode-alist))

;; 全部スペースでインデントしましょう
(add-hook 'javascript-mode-hook '(lambda() (setq indent-tabs-mode nil)))
