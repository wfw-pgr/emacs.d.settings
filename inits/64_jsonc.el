;; ;; -----------------------------------------;;
;; ;; | For json with commend mode            |;;
;; ;; -----------------------------------------;;
;; (setq auto-mode-alist
;;       (append '(("\\.json$" . js-mode)
;; 		("\\.jsonc$" . js-mode)) auto-mode-alist))

;; ---------------------------------------- ;;
;;        JSON5 モード定義                  ;;
;; ---------------------------------------- ;;
(define-derived-mode json5-mode js-mode "JSON5"
  "Major mode for editing JSON5 files with comments and @var highlighting."
  (setq-local indent-tabs-mode nil)
  (highlight-at-variables-in-json)
  (highlight-numbers-in-json)
  )

;; ---------------------------------------- ;;
;;          @var, $var ハイライト           ;;
;; ---------------------------------------- ;;
(defface at-variables-face-in-json
  '((t (:foreground "orange" :weight bold)))
  "Face for @var identifiers inside strings.")

(defun highlight-at-variables-in-json ()
  "Highlight @variable patterns inside strings."
  (font-lock-add-keywords
   nil
   '(("[@$][a-zA-Z0-9_]+"
      (0 'at-variables-face-in-json prepend)))))

;; ---------------------------------------- ;;
;;           数字  ハイライト               ;;
;; ---------------------------------------- ;;
(defface numbers-face-in-json
  '((t (:foreground "LightSkyBlue" :weight normal)))
  "Face for numbers in JSON5.")

(defun highlight-numbers-in-json ()
  "Highlight numbers in JSON5 with a custom face."
  (font-lock-add-keywords
   nil
   '(("\\(?:^\\|[^a-zA-Z0-9_.]\\)\\(-?[0-9]+\\(?:\\.[0-9]+\\)?\\(?:[eE][-+]?[0-9]+\\)?\\)"
      (1 'numbers-face-in-json prepend)))))

;; ---------------------------------------- ;;
;;        文字列 フェイス再定義             ;;
;; ---------------------------------------- ;;
(set-face-attribute 'font-lock-string-face nil
                    :foreground "Wheat"
                    :weight 'normal)

;; ---------------------------------------- ;;
;;         拡張子 へ 割当                   ;;
;; ---------------------------------------- ;;
(add-to-list 'auto-mode-alist '("\\.json\\'"  . json5-mode))
(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . json5-mode))
(add-to-list 'auto-mode-alist '("\\.json5\\'" . json5-mode))


;; ---------------------------------------- ;;
;;         その他                           ;;
;; ---------------------------------------- ;;
;; --- 全部スペースでインデントしましょう --- ;;
(add-hook 'javascript-mode-hook '(lambda() (setq indent-tabs-mode nil)))
