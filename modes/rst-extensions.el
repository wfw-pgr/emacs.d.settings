;;
;; -----------------------------------------;;
;; | For Sphinx or ReST                    |;;
;; -----------------------------------------;;
;;
;; Emacs起動時にrst.elを読み込み
(require 'rst)

;; -- 拡張子の*.rst, *.restのファイルをrst-modeで開く -- ;;
(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))
(add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))
(add-to-list 'auto-mode-alist '("\\.rst.inc$" . rst-mode))

;; -- rst-customs mode での設定 -- ;;
(add-hook 'rst-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq frame-background-mode 'dark)
            ;; キーバインド（ローカルに）
            (local-set-key (kbd "C-c r") #'rst-color-red-region)
            (local-set-key (kbd "C-c b") #'rst-color-blue-region)))

;; --  文字色変更コマンド  -- ;;
(defun rst-color-region (beg end color)
  "Wrap region with :COLOR:`...`"
  (interactive "r\nsColor: ")
  (let ((start (format " :%s:`" color))
        (end-marker "` "))
    (save-excursion
      (goto-char end)
      (insert end-marker)
      (goto-char beg)
      (insert start))))

;; --  mode 赤  -- ;;
(defun rst-color-red-region (beg end)
  "Colorize region as red"
  (interactive "r")
  (rst-color-region beg end "red"))

;; --  mode 青  -- ;;
(defun rst-color-blue-region (beg end)
  "Colorize region as blue"
  (interactive "r")
  (rst-color-region beg end "blue"))

;; --  provide ( require 用のモード名定義 ) -- ;;
(provide 'rst-extensions)
