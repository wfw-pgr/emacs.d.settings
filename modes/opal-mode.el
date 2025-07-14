
;; ================================================== ;;
;; ===   opal mode                                === ;;
;; ================================================== ;;

;; ---------------------------------------- ;;
;;    [1] OPAL モード定義                   ;;
;; ---------------------------------------- ;;
(define-derived-mode opal-mode prog-mode "OPAL"
  "Major mode for editing OPAL files with comments"
  (setq-local comment-start "//")            ;; comment
  (setq-local comment-start-skip "//+\\s-*") ;;
  (setq-local font-lock-defaults             ;; font-lock-defaults を case-insensitive 設定
              '((opal-font-lock-keywords)    ;; キーワード群
                nil t nil nil))              ;; keywords-only, case-fold,syntax-alist,syntax-begin
  ;; -- indent settings -- ;;
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 2)
  (setq-local indent-line-function #'opal-indent-line)
  ;; -- highlight functions -- ;;
  (highlight-comments-override-in-opal)
  (highlight-at-variables-in-opal)
  (highlight-numbers-in-opal)
  (highlight-numbers-inside-strings-in-opal)
  (highlight-strings-in-opal)
  (highlight-operators-in-opal)
  )

;; ---------------------------------------- ;;
;;    [2] 演算子記号 定義                   ;;
;; ---------------------------------------- ;;
(defface opal-operator-face
  '((t (:foreground "wheat" :weight bold)))
  "Face for OPAL operators.")

(defun highlight-operators-in-opal ()
  "Highlight common operators in OPAL."
  (font-lock-add-keywords
   nil
   '(("[:=;+\\-*/]" (0 'opal-operator-face prepend)))))
;; ":=" "->"

;; ---------------------------------------- ;;
;;    [3] キーワード ハイライト 定義        ;;
;; ---------------------------------------- ;;
;;    -- [3-1] フォントフェイスの定義  --   ;; 
(defface opal-keyword-face-1
  '((t (:foreground "hotpink1" :weight bold)))
  "Face for OPAL system-controls commands.")
(defface opal-keyword-face-2
  '((t (:foreground "gold2" :weight bold)))
  "Face for OPAL Fundamental commands.")
(defface opal-keyword-face-3
  '((t (:foreground "palegreen1" :weight bold)))
  "Face for OPAL Beamline components.")
(defface opal-keyword-face-4
  '((t (:foreground "aquamarine1" :weight bold)))
  "Face for OPAL Parameters.")
(defface opal-keyword-face-5
  '((t (:foreground "orchid" :weight bold)))
  "Face for OPAL analysis and control keywords.")

;;    -- [3-2] キーワード群の列挙  --       ;; 
(setq opal-keywords-1    ;; 1 - system controls ;;
      '( "if" "elseif" "else" "stop" "while" "macro" "error" "seterr" "true" "false" "umass" ))
(setq opal-keywords-2    ;; 2 - commands ;;
      '( "title" "call" "option" "beam" "line" "fieldsolver" "distribution" "select" "plot" "survey" "value" "table" "twiss" "match" "endmatch" "vary" "constraint" "track" "endtrack" "sequence" "endsequence" "start" "run" "exit" "quit" "observe" ))
(setq opal-keywords-3    ;; 3 - beamlines  ;;
      '("drift" "quadrupole" "sextupole" "octupole" "solenoid" "crabcavity" "rfcavity" "dipedge" "multipole" "collimator" "ecollimator" "rcollimator" "yrotation" "srotation" "translation" "changeref" "marker" "rbend" "sbend" "hkicker" "vkicker" "kicker" "tkicker" "elseparator" "hmonitor" "vmonitor" "monitor" "instrument" "placeholder" "beambeam" "matrix" "nllens" "rfmultipole"))
(setq opal-keywords-4    ;; 4 - arguments, keywords ;;
      '( "file" "flag"
	 "fstype" "mx" "my" "mt" "bboxincr" "offsetx" "offsety" "offsetz" "offsetpx" "offsetpy" "offsetpz" "sigmax" "sigmay" "sigmaz" "corrx" "corry" "corrz" "cutoffx" "cutoffy" "cutofflong" 
	 "particle" "mass" "charge" "energy" "column" "e" "s" "l" "k1" "angle" "name" "haxis" "vaxis" "betx" "bety" "betz" "alfx" "alfy" "emitx" "emity" "dx" "dy" "dpx" "dpy" "mux" "muy" "centre" "save" "positron" "electron" "proton" "antiproton" "posmuon" "negmuon" "ion" "pi" "twopi" "degrad" "raddeg" "entry" "centre" "exit" "circle" "rectangle" "ellipse" "seed" "add" "pattern" "echo"))
;; -- "qelect" "hbar" "erad" "prad" "simple" "collim" "teapot" "hybrid"
(setq opal-keywords-5    ;; 6 - math ;;
      '("real" "bool"  "sqrt" "log" "log10" "exp" "sin" "cos" "tan" "asin" "acos" "atan" "sinh" "cosh" "tanh" "sinc" "abs" "erf" "erfc" "floor" "ceil" "round" "ranf" "gauss" "tgauss" "emass" "pmass" "nmass" "mumass" "clight" ))

;;    -- [3-3] キーワードとフェイスを対応 (case-insensitive)  --  ;;
(defvar opal-font-lock-keywords
  `((,(regexp-opt opal-keywords-1 'words) . 'opal-keyword-face-1)
    (,(regexp-opt opal-keywords-2 'words) . 'opal-keyword-face-2)
    (,(regexp-opt opal-keywords-3 'words) . 'opal-keyword-face-3)
    (,(regexp-opt opal-keywords-4 'words) . 'opal-keyword-face-4)
    (,(regexp-opt opal-keywords-5 'words) . 'opal-keyword-face-5)))


;; ---------------------------------------- ;;
;;    [4] @var #var  (マクロ記号)           ;;
;; ---------------------------------------- ;;
(defface at-variables-face-in-opal
  '((t (:foreground "orange" :weight bold)))
  "Face for @var identifiers inside strings.")

(defun highlight-at-variables-in-opal()
  "Highlight @variable (#variable) patterns inside strings."
  (font-lock-add-keywords
   nil
   '(("[@#][a-zA-Z0-9_.]+"
      (0 'at-variables-face-in-opal prepend)))))

;; ---------------------------------------- ;;
;;    [5] 文字列 ハイライト                 ;;
;; ---------------------------------------- ;;
(defface strings-face-in-opal
  '((t (:foreground "BurlyWood" :weight normal)))
  "Custom face for strings in opal-mode")

(defun highlight-strings-in-opal ()
  "Highlight strings in OPAL with custom face."
  (font-lock-add-keywords
   nil
   '(("\"\\([^\"\\]\\|\\\\.\\)*\""
      (0 'strings-face-in-opal prepend)))))

;; ---------------------------------------- ;;
;;     [6] 数字  ハイライト                 ;;
;; ---------------------------------------- ;;
(defface numbers-face-in-opal
  '((t (:foreground "Cyan" :weight normal)))
  "Face for numbers in OPAL.")

(defun highlight-numbers-in-opal ()
  "Highlight numbers in OPAL with a custom face."
  (font-lock-add-keywords
   nil
   '(("\\(?:^\\|[^a-zA-Z0-9_.]\\)\\(-?[0-9]+\\(?:\\.[0-9]+\\)?\\(?:[eE][-+]?[0-9]+\\)?\\)"
      (1 'numbers-face-in-opal prepend)))))

(defun highlight-numbers-inside-strings-in-opal ()
  "Highlight numbers even inside strings."
  (font-lock-add-keywords
   nil
   '(("\"[^\"]*?\\([0-9]+\\(?:\\.[0-9]+\\)?\\(?:[eE][-+]?[0-9]+\\)?\\)[^\"]*?\""
      (1 'numbers-face-in-opal prepend)))))

(defun highlight-comments-override-in-opal ()
  "Forcefully highlight comments to override other face rules."
  (font-lock-add-keywords
   nil
   '(("//\\(.*\\)$"  ; キャプチャグループ1に色をつける
      (0 'font-lock-comment-face prepend)))))


;; ---------------------------------------- ;;
;;     [7] フックする拡張子 の設定          ;;
;; ---------------------------------------- ;;
(add-to-list 'auto-mode-alist '("\\.opal\\'" . opal-mode))
(add-to-list 'auto-mode-alist '("\\.in\\'"  . opal-mode))

;; ---------------------------------------- ;;
;;     [8] インデント                       ;;
;; ---------------------------------------- ;;

;; indent :: base == js ;;
(require 'js)
(defun opal-inside-sequence-p ()
  "Return non-nil if point is inside a OPAL block like sequence, match, track, etc."
  (save-excursion
    (let ((start nil)
          (end nil)
	  ;; 開始キーワード 定義
	  (start-keywords '("sequence" "match" "track"))
	  ;; 終了キーワード 定義
          (end-keywords '("endsequence" "endmatch" "endtrack" )))
      ;;  --- 開始 マッチ ---  ;;
      (dolist (kw start-keywords)
        (unless start
          (save-excursion
            (when (re-search-backward (format "^\\s-*\\(?:[A-Za-z0-9_]+:\\s-*\\)?%s\\b" kw) nil t)
              (setq start (point))))))
      ;;  --- 終了 マッチ ---  ;;
      (dolist (kw end-keywords)
        (unless end
          (save-excursion
            (when (re-search-backward (format "^\\s-*\\(?:[A-Za-z0-9_]+:\\s-*\\)?%s\\b" kw) nil t)
              (setq end (point))))))
      (and start (or (not end) (> start end))))))


;; indent :: base == js ;;

(defvar opal-basic-indent 2
  "OPAL mode basic indentation step.")

(defun opal-indent-line ()
  "Indent using js-mode-like logic, and increase indent inside sequence blocks."
  (interactive)
  ;; ベースインデントを仮取得
  (let ((base-indent
         (save-excursion
           (beginning-of-line)
           (let ((pos (point)))
             ;; js風インデントを適用して、そのインデント幅を取得する
             (if (fboundp 'js-indent-line)
                 (progn
                   (funcall 'js-indent-line)
                   (current-indentation))
               (current-indentation)))))
        (line (thing-at-point 'line t)))

    ;; endsequence の行は特別扱い：インデントを 1 段階減らす
    (cond
     ((string-match-p "^\\s-*\\(?:[A-Za-z0-9_]+:\\s-*\\)?endsequence\\b" line)
      (indent-line-to (max 0 (- base-indent opal-basic-indent))))
     ((string-match-p "^\\s-*\\(?:[A-Za-z0-9_]+:\\s-*\\)?endmatch\\b" line)
      (indent-line-to (max 0 (- base-indent opal-basic-indent))))
     ((string-match-p "^\\s-*\\(?:[A-Za-z0-9_]+:\\s-*\\)?endtrack\\b" line)
      (indent-line-to (max 0 (- base-indent opal-basic-indent))))

     ;; sequenceブロック中の行は base + 1 段階
     ((opal-inside-sequence-p)
      (indent-line-to (+ base-indent opal-basic-indent)))

     ;; その他は base-indent にする
     (t
      (indent-line-to base-indent)))))

;; ---------------------------------------- ;;
;;         provide                          ;;
;; ---------------------------------------- ;;
(provide 'opal-mode)
