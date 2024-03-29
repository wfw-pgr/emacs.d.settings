;; ========================================;;
;; === 追加命令                         ===;;
;; ========================================;;
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
  "Interactive call to revert-buffer. Ignoring the auto-save file and not requesting for confirmation. When the current buffer is modified, the command refuses to revert it, unless you specify the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))
;; -- Revert バッファ を フック --- ;;
(global-set-key "\M-r" 'revert-buffer-no-confirm)


;; --------------------------------------- ;;
;; --- [3] emacs を最大化              --- ;;
;; --------------------------------------- ;;
;; 画面最大化するコマンド == Ctr-x + w
(global-set-key "\C-xw" '(lambda ()
                           (interactive)
                           (toggle-frame-maximized)))


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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert file name at point                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://www.emacswiki.org/emacs/InsertFileName
(defun bjm/insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.
  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.
  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.
  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (expand-file-name filename)))
        ((not (null args))
         (insert filename))
        (t
         (insert (file-relative-name filename)))))

;; bind it
(global-set-key (kbd "C-c i") 'bjm/insert-file-name)
