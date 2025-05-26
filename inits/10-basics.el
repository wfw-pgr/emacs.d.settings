;; ================================================== ;;
;; ===   50    General Settings                   === ;;
;; ================================================== ;;

;; --------------------------------------- ;;
;; --- [1] Window size                 --- ;;
;; --------------------------------------- ;;
(setq initial-frame-alist '((fullscreen . maximized)) )
;; (add-to-list 'default-frame-alist '(undecorated .t))         ;; -- 枠なし -- ;;


;; --------------------------------------- ;;
;; --- [2] Color theme                 --- ;;
;; --------------------------------------- ;;
(setq custom-theme-directory "~/.emacs.d/themes")
(load-theme 'mytheme t)

;; --------------------------------------- ;;
;; --- [3] Preferences                 --- ;;
;; --------------------------------------- ;;
;;
;; バックアップファイルの保存先ディレクトリ
(setq backup-directory-alist
      (cons (cons ".*" (expand-file-name "~/.emacs.d/backups/"))
            backup-directory-alist))
;; 自動保存ファイルの保存先ディレクトリ
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backups/") t)))
;;

(menu-bar-mode -1)                    ;; -- メニューバー要らない     -- ;;
(tool-bar-mode -1)                    ;; -- ツールバー  要らない     -- ;;
(scroll-bar-mode -1)                  ;; -- スクロールバー  要らない -- ;;
;; (global-linum-mode t)                 ;; -- 行番号を常に表示         -- ;;
(global-hl-line-mode t)               ;; -- カーソル行をハイライト   -- ;;

(show-paren-mode 1)                   ;; -- 対応する括弧を光らせる   -- ;;
(setq ring-bell-function 'ignore)     ;; -- beep off                 -- ;;
(setq scroll-conservatively 1)        ;; -- スクロールは１行ごとに   -- ;;
(setq isearch-case-fold-search t)     ;; -- インクリメンタルサーチ時には大文字小文字の区別をしない -- ;;
(display-time)                        ;; -- モードラインに時刻表示   -- ;;
(line-number-mode t)                  ;; -- 行番号、桁番号を表示する -- ;;
(transient-mark-mode 1)               ;; -- リージョンを光らせる     -- ;;
(defalias 'yes-or-no-p 'y-or-n-p)     ;; -- yes => y , no => n       -- ;;

;; -- 大文字・小文字区別 case-insensitiveにする -- ;;
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; -- ウィンドウ制御 -- ;;
(setq inhibit-startup-message t)      ;; 起動時のウィンドウは一つ 
(add-hook 'window-setup-hook          ;; macOS起動時、背面にを改善
          (lambda ()
            (when (eq system-type 'darwin)
              (do-applescript "tell application \"Emacs\" to activate"))))
