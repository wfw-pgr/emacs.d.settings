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
  (json5-disable-syntax-highlighting)
  (highlight-at-variables-in-json)
  (highlight-numbers-in-json)
  (highlight-numbers-inside-strings-in-json)
  (highlight-strings-in-json)
  (highlight-comments-override-in-json)
  )

(defun json5-disable-syntax-highlighting ()
  "Disable js-mode's automatic syntax highlighting for strings/comments."
  (setq-local font-lock-syntactic-face-function nil))


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
   '(("[@$][a-zA-Z0-9_.]+"
      (0 'at-variables-face-in-json prepend)))))

;; ---------------------------------------- ;;
;;        文字列 ハイライト                 ;;
;; ---------------------------------------- ;;
(defface strings-face-in-json
  '((t (:foreground "BurlyWood" :weight normal)))
  "Custom face for strings in json5-mode")

(defun highlight-strings-in-json ()
  "Highlight strings in JSON5 with custom face."
  (font-lock-add-keywords
   nil
   '(("\"\\([^\"\\]\\|\\\\.\\)*\""
      (0 'strings-face-in-json prepend)))))

;; ---------------------------------------- ;;
;;           数字  ハイライト               ;;
;; ---------------------------------------- ;;
(defface numbers-face-in-json
  '((t (:foreground "Cyan" :weight normal)))
  "Face for numbers in JSON5.")

(defun highlight-numbers-in-json ()
  "Highlight numbers in JSON5 with a custom face."
  (font-lock-add-keywords
   nil
   '(("\\(?:^\\|[^a-zA-Z0-9_.]\\)\\(-?[0-9]+\\(?:\\.[0-9]+\\)?\\(?:[eE][-+]?[0-9]+\\)?\\)"
      (1 'numbers-face-in-json prepend)))))

(defun highlight-numbers-inside-strings-in-json ()
  "Highlight numbers even inside strings."
  (font-lock-add-keywords
   nil
   '(("\"[^\"]*?\\([0-9]+\\(?:\\.[0-9]+\\)?\\(?:[eE][-+]?[0-9]+\\)?\\)[^\"]*?\""
      (1 'numbers-face-in-json prepend)))))


;; ---------------------------------------- ;;
;;      コメント ハイライト (強制)          ;;
;; ---------------------------------------- ;;
(defun highlight-comments-override-in-json ()
  "Force comment face on comment regions to override others."
  (font-lock-add-keywords
   nil
   '(("//.*$"
      (1 'font-lock-comment-face prepend)))))

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
