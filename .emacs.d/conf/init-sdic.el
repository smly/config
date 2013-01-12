;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ref: http://d.hatena.ne.jp/khiker/20070518/emacs_sdic
(add-to-load-path "/usr/local/share/emacs/site-lisp")

(autoload 'sdic-describe-word "sdic" "search word" t nil)
(global-set-key "\C-ce" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソル位置の英単語の意味を調べる" t nil)
(global-set-key "\C-c\C-e" 'sdic-describe-word-at-point)
(setq sdic-window-height 25)
(setq sdic-default-coding-system 'utf-8-unix) ;; 使う辞書は utf-8 なので

(eval-after-load "sdic"
  '(progn
     ;; saryのコマンドをセットする
     (setq sdicf-array-command "/usr/bin/sary")
     ;; sdicファイルのある位置を設定し、arrayコマンドを使用するよう設定(現在のところ英和のみ)
     (setq sdic-eiwa-dictionary-list
           '((sdicf-client "/dev/shm/eijirou.sdic"
                           (strategy array)))
           sdic-waei-dictionary-list
           '((sdicf-client "/home/smly/dict/waeijirou.sdic"
                           (strategy array))))
     ;; saryを直接使用できるように sdicf.el 内に定義されているarrayコマンド用関数を強制的に置換
     (fset 'sdicf-array-init 'sdicf-common-init)
     (fset 'sdicf-array-quit 'sdicf-common-quit)
     (fset 'sdicf-array-search
           (lambda (sdic pattern &optional case regexp)
             (sdicf-array-init sdic)
             (if regexp
                 (signal 'sdicf-invalid-method '(regexp))
               (save-excursion
                 (set-buffer (sdicf-get-buffer sdic))
                 (delete-region (point-min) (point-max))
                 (apply 'sdicf-call-process
                        sdicf-array-command
                        (sdicf-get-coding-system sdic)
                        nil t nil
                        (if case
                            (list "-i" pattern (sdicf-get-filename sdic))
                          (list pattern (sdicf-get-filename sdic))))
                 (goto-char (point-min))
                 (let (entries)
                   (while (not (eobp)) (sdicf-search-internal))
                   (nreverse entries))))))
     ;; おまけ--辞書バッファ内で移動した時、常にバッファの一行目になるようにする
     (defadvice sdic-forward-item (after sdic-forward-item-always-top activate)
       (recenter 0))
     (defadvice sdic-backward-item (after sdic-backward-item-always-top activate)
       (recenter 0))))

; 検索結果表示バッファで引いた単語をハイライト表示する
(defadvice sdic-search-eiwa-dictionary (after highlight-phrase (arg))
    (highlight-phrase arg "hi-yellow"))
(defadvice sdic-search-waei-dictionary (after highlight-phrase (arg))
    (highlight-phrase arg "hi-yellow"))

(ad-activate 'sdic-search-eiwa-dictionary)
(ad-activate 'sdic-search-waei-dictionary)
