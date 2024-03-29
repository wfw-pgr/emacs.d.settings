;; ========================================= ;;
;;  python mode                              ;;
;; ========================================= ;;

;; ----------------------------------------------------------- ;;
;; --- 小フォントサイズ化して日本語まじりコメント許可      --- ;;
;; ----------------------------------------------------------- ;;
(eval-after-load 'flymake '(require 'flymake-cursor))
(defun python-buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "ricty" :height 140 :width semi-condensed) )
  (buffer-face-mode))
(add-hook 'python-mode-hook 'python-buffer-face-mode-variable)

;; ----------------------------------------------------------- ;;
;; --- flymake for python ( 自動コンパイル訂正 )          ---  ;;
;; ----------------------------------------------------------- ;;
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "/usr/local/bin/pyflakes"  (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))
;;; -- flymake はミニバッファに表示 -- ;;;;
;; (defun flymake-show-help ()
;;   (when (get-char-property (point) 'flymake-overlay)
;;     (let ((help (get-char-property (point) 'help-echo)))
;;       (if help (message "%s" help)))))
;; (add-hook 'post-command-hook 'flymake-show-help)
