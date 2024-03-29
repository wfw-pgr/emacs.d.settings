;; ----------------------------------------;;
;; | 一般設定                             |;;
;; ----------------------------------------;;

;; 言語環境仕様 :: 
(set-language-environment 'Japanese)

;; Coding system.文字コード :: 
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Window size ::
(setq initial-frame-alist
      '((top . 0) (left . 0) (width . 110) (height . 130)))

;; Font Setting ;;
(add-to-list 'default-frame-alist '(font . "ricty-11"))
;; (add-to-list 'default-frame-alist '(font . "Myrica M"))
;; Package Manegement ;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;テーマフレームでカラーテーマ変更
; color theme
(setq custom-theme-directory "~/.emacs.d/cthemes/")
(load-theme 'molokai t)

;; ;;行番号を常に表示 --- ごちゃごちゃする
;; (global-linum-mode t)

;; バックアップファイルの保存先ディレクトリ
(setq backup-directory-alist
      (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
	    backup-directory-alist))
;; 自動保存ファイルの保存先ディレクトリ
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; メニューバー要らない
;; (menu-bar-mode -1)
;; ツールバー要らない
;; (tool-bar-mode -1)
;; カーソル行をハイライトする
(global-hl-line-mode t)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; インクリメンタルサーチ時には大文字小文字の区別をしない
(setq isearch-case-fold-search t)

;; 大文字・小文字区別 case-insensitiveにする
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; モードラインに時刻を表示
(display-time)

;; 行番号、桁番号を表示する
(line-number-mode t)

;; リージョンに色をつける
(transient-mark-mode 1)

;; yes -> y
(defalias 'yes-or-no-p 'y-or-n-p)

;;spell check スペルチェック ;; 
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")
(define-obsolete-variable-alias 'last-command-char 'last-command-event "at least 19.34") 


;; --------------------------------------- ;;
;; --- [2] オープンコマンド            --- ;;
;; --------------------------------------- ;;

;; init.el を開くコマンド ;;
(defun open-init-el ()
  "init.elを開く"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; default.conf を開くコマンド ;;
(defun open-default-conf ()
  "default.confを開く"
  (interactive)
  (find-file "~/.python/lib/nkUtilities/default.conf"))

;; .python/lib を開くコマンド ;;
(defun open-pythonlib ()
  "~/.python/lib を開く"
  (interactive)
  (find-file "~/.python/lib/"))


;; ;; flycheck / flymake
;; (global-flycheck-mode -1)
;; (global-flymake-mode -1)
