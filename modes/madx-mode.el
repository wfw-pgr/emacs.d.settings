
;; ================================================== ;;
;; ===   madx mode                                === ;;
;; ================================================== ;;

;; ---------------------------------------- ;;
;;    [1] MADX モード定義                   ;;
;; ---------------------------------------- ;;
(define-derived-mode madx-mode prog-mode "MAD-X"
  "Major mode for editing MAD-X files with comments"
  (setq-local indent-tabs-mode nil)
  (setq-local comment-start "//")            ;; comment
  (setq-local comment-start-skip "//+\\s-*") ;;
  (setq-local font-lock-defaults             ;; font-lock-defaults を case-insensitive 設定
              '((madx-font-lock-keywords)    ;; キーワード群
                nil t nil nil))              ;; keywords-only, case-fold,syntax-alist,syntax-begin
  (setq-local indent-line-function 'madx-indent-line)
  ;; -- highlight functions -- ;;
  (highlight-comments-override-in-madx)
  (highlight-at-variables-in-madx)
  (highlight-numbers-in-madx)
  (highlight-numbers-inside-strings-in-madx)
  (highlight-strings-in-madx)
  (highlight-operators-in-madx)
  (highlight-keywords-in-madx)
  )

;; ---------------------------------------- ;;
;;    [2] 演算子記号 定義                   ;;
;; ---------------------------------------- ;;
(defface madx-operator-face
  '((t (:foreground "wheat" :weight bold)))
  "Face for MAD-X operators.")

(defun highlight-operators-in-madx ()
  "Highlight common operators in MAD-X."
  (font-lock-add-keywords
   nil
   '(("[:=;+\\-*/]" (0 'madx-operator-face prepend)))))
;; ":=" "->"

;; ---------------------------------------- ;;
;;    [3] キーワード ハイライト 定義        ;;
;; ---------------------------------------- ;;
;;    -- [3-1] フォントフェイスの定義  --   ;; 
(defface madx-keyword-face-1
  '((t (:foreground "hotpink1" :weight bold)))
  "Face for MAD-X   system-controls commands.")
(defface madx-keyword-face-2
  '((t (:foreground "gold2" :weight bold)))
  "Face for MAD-X   Fundamental commands.")
(defface madx-keyword-face-3
  '((t (:foreground "palegreen1" :weight bold)))
  "Face for MAD-X   Beamline components.")
(defface madx-keyword-face-4
  '((t (:foreground "aquamarine1" :weight bold)))
  "Face for MAD-X   Parameters.")
(defface madx-keyword-face-5
  '((t (:foreground "orchid" :weight bold)))
  "Face for MAD-X analysis and control keywords.")

;;    -- [3-2] キーワード群の列挙  --       ;; 
(setq madx-keywords-1   ;; 1 - system controls ;;
      '( "if" "elseif" "else" "stop" "while" "macro" "error" "ealign" "efcomp" "seterr" "true" "false"))
(setq madx-keywords-2   ;; 2 - commands ;;
      '("call" "beam" "plot" "survey" "value" "table" "tabindex" "tabstring" "twiss" "match" "endmatch" "vary" "constraint" "track" "endtrack" "start" "run" "exit" "quit" "observe" "ibs" "line" "makethin" "aperture" "sixtrack" "dynap" "emit" "weight" "global" "gweight" "ptc_twiss" "ptc_printparametric" "ptc_normal" "select_ptc_normal" "ptc_track" "ptc_track_line" "ptc_create_universe" "ptc_create_layout" "ptc_read_errors" "ptc_move_to_layout" "ptc_align" "ptc_end" "ptc_track_end" "ptc_observe" "ptc_start" "ptc_setswitch" "ptc_knob" "ptc_setknobvalue" "match withptcknobs" "ptc_printframes" "ptc_select" "ptc_select_moment" "ptc_dumpmaps" "ptc_eplacement" "ptc_varyknob" "end_match" "ptc_moments" "ptc_setcavities" "ptc_setdebuglevel" "ptc_setaccel_method" "ptc_setexactmis" "ptc_setradiation" "ptc_settotalpath" "ptc_settime" "ptc_setfringe" "help" "show" "option" "exec" "set" "system" "title" "use" "select" "assign" "return" "print" "printf" "renamefile" "copyfile" "removefile" "create" "delete" "readtable" "readmytable" "write" "setvars" "setvars_lin" "fill" "shrink" "resbeam" "seqedit" "flatten" "cycle" "reflect" "install" "move" "remove" "replace" "extract" "endedit" "dumpsequ" "savebeta" "coguess" "const" "eoption" "esave" "real" "lmdif" "migrad" "simplex" "jacobian" "use_macro" "correct" "usemonitor" "usekick" "csave" "setcorr" "coption" "sodd" "sxfread" "sxfwrite" "touschek"  ))
(setq madx-keywords-3    ;; 3 - beamlines  ;;
      '("drift" "quadrupole" "sextupole" "octupole" "solenoid" "crabcavity" "rfcavity" "dipedge" "multipole" "collimator" "ecollimator" "rcollimator" "yrotation" "srotation" "translation" "changeref" "marker" "rbend" "sbend" "hkicker" "vkicker" "kicker" "tkicker" "elseparator" "hmonitor" "vmonitor" "monitor" "instrument" "placeholder" "beambeam" "matrix" "nllens" "rfmultipole"))
(setq madx-keywords-4    ;; 4 - arguments, keywords ;;
      '("file" "flag" "sequence" "endsequence" "refer" "particle" "energy" "column" "e" "s" "l" "k1" "angle" "name" "haxis" "vaxis" "betx" "bety" "alfx" "alfy" "emitx" "emity" "centre" "save" "positron" "electron" "proton" "antiproton" "posmuon" "negmuon" "ion" "pi" "twopi" "degrad" "raddeg" "entry" "centre" "exit" "circle" "rectangle" "ellipse" "emass" "pmass" "nmass" "mumass" "clight"))
;; -- "qelect" "hbar" "erad" "prad" "simple" "collim" "teapot" "hybrid"

(setq madx-keywords-5    ;; 6 - math ;;
      '("sqrt" "log" "log10" "exp" "sin" "cos" "tan" "asin" "acos" "atan" "sinh" "cosh" "tanh" "sinc" "abs" "erf" "erfc" "floor" "ceil" "round" "ranf" "gauss" "tgauss"))

;;    -- [3-3] キーワードとフェイスを対応 (case-insensitive)  --  ;;
(defvar madx-font-lock-keywords
  `((,(regexp-opt madx-keywords-1 'words) . 'madx-keyword-face-1)
    (,(regexp-opt madx-keywords-2 'words) . 'madx-keyword-face-2)
    (,(regexp-opt madx-keywords-3 'words) . 'madx-keyword-face-3)
    (,(regexp-opt madx-keywords-4 'words) . 'madx-keyword-face-4)
    (,(regexp-opt madx-keywords-5 'words) . 'madx-keyword-face-5)))


;; ---------------------------------------- ;;
;;    [4] @var #var  (マクロ記号)           ;;
;; ---------------------------------------- ;;
(defface at-variables-face-in-madx
  '((t (:foreground "orange" :weight bold)))
  "Face for @var identifiers inside strings.")

(defun highlight-at-variables-in-madx ()
  "Highlight @variable (#variable) patterns inside strings."
  (font-lock-add-keywords
   nil
   '(("[@#][a-zA-Z0-9_.]+"
      (0 'at-variables-face-in-madx prepend)))))

;; ---------------------------------------- ;;
;;    [5] 文字列 ハイライト                 ;;
;; ---------------------------------------- ;;
(defface strings-face-in-madx
  '((t (:foreground "BurlyWood" :weight normal)))
  "Custom face for strings in madx-mode")

(defun highlight-strings-in-madx ()
  "Highlight strings in MADX with custom face."
  (font-lock-add-keywords
   nil
   '(("\"\\([^\"\\]\\|\\\\.\\)*\""
      (0 'strings-face-in-madx prepend)))))

;; ---------------------------------------- ;;
;;     [6] 数字  ハイライト                 ;;
;; ---------------------------------------- ;;
(defface numbers-face-in-madx
  '((t (:foreground "Cyan" :weight normal)))
  "Face for numbers in MADX.")

(defun highlight-numbers-in-madx ()
  "Highlight numbers in MADX with a custom face."
  (font-lock-add-keywords
   nil
   '(("\\(?:^\\|[^a-zA-Z0-9_.]\\)\\(-?[0-9]+\\(?:\\.[0-9]+\\)?\\(?:[eE][-+]?[0-9]+\\)?\\)"
      (1 'numbers-face-in-madx prepend)))))

(defun highlight-numbers-inside-strings-in-madx ()
  "Highlight numbers even inside strings."
  (font-lock-add-keywords
   nil
   '(("\"[^\"]*?\\([0-9]+\\(?:\\.[0-9]+\\)?\\(?:[eE][-+]?[0-9]+\\)?\\)[^\"]*?\""
      (1 'numbers-face-in-madx prepend)))))

(defun highlight-comments-override-in-madx ()
  "Forcefully highlight comments to override other face rules."
  (font-lock-add-keywords
   nil
   '(("//\\(.*\\)$"  ; キャプチャグループ1に色をつける
      (0 'font-lock-comment-face prepend)))))


;; ---------------------------------------- ;;
;;     [7] フックする拡張子 の設定          ;;
;; ---------------------------------------- ;;
(add-to-list 'auto-mode-alist '("\\.madx\\'" . madx-mode))

;; ---------------------------------------- ;;
;;     [8] インデント                       ;;
;; ---------------------------------------- ;;
;; --- 全部スペースでインデント         --- ;;
(add-hook 'javascript-mode-hook '(lambda() (setq indent-tabs-mode nil)))

;; --- 全部スペースでインデント         --- ;;
(defun madx-inside-sequence-p ()
  "Return non-nil if the current line is inside a SEQUENCE...ENDSEQUENCE block."
  (save-excursion
    (let ((seq-pos nil)
          (endseq-pos nil))
      ;; 現在行より前の SEQUENCE を探す
      (when (re-search-backward "^[ \t]*SEQUENCE\\b" nil t)
        (setq seq-pos (point)))
      (goto-char (point-at-bol))
      ;; 現在行より後の ENDSEQUENCE を探す
      (when (re-search-forward "^[ \t]*ENDSEQUENCE\\b" nil t)
        (setq endseq-pos (point)))
      ;; どちらも見つかり、かつ現在位置がその間なら t
      (and seq-pos endseq-pos
           (> endseq-pos (point))
           (< seq-pos (point))))))

(defun madx-indent-line ()
  "Indent current line if inside SEQUENCE...ENDSEQUENCE block."
  (interactive)
  (let ((indent (if (madx-inside-sequence-p) tab-width 0)))
    (save-excursion
      (beginning-of-line)
      (delete-horizontal-space)
      (indent-to indent))
    (when (looking-back "^[ \t]*" (line-beginning-position))
      (back-to-indentation))))

;; ---------------------------------------- ;;
;;         provide                          ;;
;; ---------------------------------------- ;;
(provide 'madx-mode)
