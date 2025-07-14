
;; -------------------------------------------------- ;;
;; ---   21    Original Functions                 --- ;;
;; -------------------------------------------------- ;;

;; --------------------------------------- ;;
;; --- [1] C-x #で画面横３分割         --- ;;
;; --------------------------------------- ;;
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
(global-set-key "\C-x#" '(lambda ()
                           (interactive)
                           (split-window-horizontally-n 3)))

;; --------------------------------------- ;;
;; --- [2] 更新コマンド                --- ;;
;; --------------------------------------- ;;
;; Ctr-r == update window ;;
(defun revert-buffer-no-confirm (&optional force-reverting)
  (interactive "P")
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))
;; -- Revert バッファ を フック --- ;;
(global-set-key "\M-r" 'revert-buffer-no-confirm)


;; --------------------------------------- ;;
;; --- [3] emacsを最大化 (Ctr-x +w)    --- ;;
;; --------------------------------------- ;;
;; 画面最大化するコマンド == 
(global-set-key "\C-xw" 'toggle-frame-maximized)

;; --------------------------------------- ;;
;; --- [4] 整列コマンド (align-regexp) --- ;;
;; --------------------------------------- ;;
;; 空白でスペース
;; Align with spaces only
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)
(global-set-key "\C-xt" 'align-regexp)


;; --------------------------------------- ;;
;; --- [5] File 名入力関数             --- ;;
;; --------------------------------------- ;;
;;  -- https://www.emacswiki.org/emacs/InsertFileName -- ;;
(defun bjm/insert-file-name (filename &optional args)
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (expand-file-name filename)))
        ((not (null args))
         (insert filename))
        (t
         (insert (file-relative-name filename))))
  )
(global-set-key (kbd "C-c i") 'bjm/insert-file-name)





;; -------------------------------------------------- ;;
;; ---   22 Original modes load                   --- ;;
;; -------------------------------------------------- ;;

;; --------------------------------------- ;;
;; --- [1] Original mode / theme       --- ;;
;; --------------------------------------- ;;
(add-to-list 'load-path "~/.emacs.d/modes/")
(require 'def-mode)
(require 'phits-mode)
(require 'elmer-mode)
(require 'jsonc-mode)
(require 'rst-extensions)
(require 'madx-mode)
(require 'opal-mode)

;; --------------------------------------- ;;
;; --- [2] yasnippets                  --- ;;
;; --------------------------------------- ;;
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/elpa/yasnippet/"))
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/elpa/yasnippet-snippets-20190422.1416/"))
;; 自分用・追加用テンプレート -> mysnippetに作成したテンプレートが格納される
(add-to-list 'load-path
	     "~/.emacs.d/lisps/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))
(yas-global-mode 1)

