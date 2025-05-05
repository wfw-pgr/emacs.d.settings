
;; ================================================== ;;
;; ===   00  Language                             === ;;
;; ================================================== ;;
;;
;; ---------------------------- ;;
;; --- language :: Japanese --- ;;
;; ---------------------------- ;;
;; 
(set-language-environment "Japanese")

(prefer-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; --- default fonts for japanese -- ;;
;;
;;  -- HackGen Fonts --  ;;
;; (set-frame-font "HackGen-13" nil t)
;; (set-fontset-font t 'japanese-jisx0208 "HackGen")    -- Ricty-14 = HackGen-13 --
;; 
;;  --  Ricty  Fonts --  ;;
(set-frame-font "ricty-14" nil t)
(set-fontset-font t 'japanese-jisx0208 "Ricty")
;;


;; ------------------------------------ ;;
;; --   Windows WSL2用 日本語設定   -- ;;
;; ------------------------------------ ;;

;; ;; --- 日本語IMEの設定 --- ;;
;; (require 'mozc)
;; (setq default-input-method "japanese-mozc")
;; (global-set-key [zenkaku-hankaku] 'toggle-input-method)

;; ;;  -- macOS-like な変換 --- ;;
;; (defun my-ime-on () "日本語入力ON"
;;   (interactive)
;;   (unless current-input-method
;;     (toggle-input-method))
;;   )
;; (defun my-ime-off () "日本語入力OFF"
;;   (interactive)
;;   (when current-input-method
;;     (deactivate-input-method))
;;   )
;; (global-set-key [henkan]   'my-ime-on)
;; (global-set-key [muhenkan] 'my-ime-off)

;; ;; モードラインでIME状態を表示（任意）
;; (setq-default mode-line-format
;;               (append mode-line-format
;;                       '((:eval (if current-input-method "[あ]" "[--]")))))
