;; -----------------------------------------;;
;; | For Sphinx or ReST                    |;;
;; -----------------------------------------;;
;; .rst.incをreSTに紐付け
;; Emacs起動時にrst.elを読み込み
(require 'rst)
;; 拡張子の*.rst, *.restのファイルをrst-modeで開く
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
		("\\.rest$" . rst-mode)
		("\\.rst.inc$" . rst-mode)) auto-mode-alist))
;; 背景が黒い場合はこうしないと見出しが見づらい
(setq frame-background-mode 'dark)
;; 全部スペースでインデントしましょう
(add-hook 'rst-mode-hook '(lambda() (setq indent-tabs-mode nil)))


;; --  文字色変更コマンド  -- ;;
(defun rst-color-region (beg end color)
  "Wrap the selected region with :COLOR:`...` for Sphinx."
  (let ((start (format " :%s:`" color))
        (end-marker "` "))
    (save-excursion
      (goto-char end)
      (insert end-marker)
      (goto-char beg)
      (insert start))))

;; --  mode 赤  -- ;;
(defun rst-color-red-region (beg end)
  "Wrap the selected region with :red:`...`"
  (interactive "r")
  (rst-color-region beg end "red"))

;; --  mode 青  -- ;;
(defun rst-color-blue-region (beg end)
  "Wrap the selected region with :blue:`...`"
  (interactive "r")
  (rst-color-region beg end "blue"))

;; 文字色変更コマンド ショートカット ;;
(global-set-key (kbd "C-c r") #'rst-color-red-region)
(global-set-key (kbd "C-c b") #'rst-color-blue-region)
