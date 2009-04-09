(defun python-partial-symbol ()
  "Return the partial symbol before point (for completion)."
  (let ((end (point))
        (start (save-excursion
                 (and (re-search-backward
                       (rx (or buffer-start (regexp "[^[:alnum:]._]"))
                           (group (1+ (regexp "[[:alnum:]._]"))) point)
                       nil t)
                      (match-beginning 1)))))
    (if start (buffer-substring-no-properties start end))))

(defun pydoc-to-tip (w)
    "Launch PyDOC on the Word at Point to tooltip"
    (interactive
     (list (let* ((word (python-partial-symbol)))
             (if (not word) (tooltip-show-help "No pydoc args given")
               word))))
    (tooltip-show
     (shell-command-to-string
      (concat "python2.6  -c \"from pydoc import help;help(\'" w "\')\""))))

(defun my-python-documentation (w)
    "Launch PyDOC on the Word at Point"
    (interactive
     (list (let* ((word (python-partial-symbol))
                  (input (read-string
                          (format "pydoc entry%s: "
                                  (if (not word) "" (format " (default %s)" word
                                                            ))))))
             (if (string= input "")
                 (if (not word) (error "No pydoc args given")
                   word) ;sinon word
               input)))) ;sinon input
    (shell-command (concat "python2.6 -c \"from pydoc import help;help(\'" w "\')\"") "*PYDOCS*")
    (view-buffer-other-window "*PYDOCS*" t 'kill-buffer-and-window)
    )

(defun python-symbol-completions (symbol)
  "Return a list of completions of the string SYMBOL from Python process. The list is sorted."
  (when symbol
    (let ((completions
           (condition-case ()
               (car (read-from-string
                                        ;(mapcar #'symbol-name (car (read-from-string ;"(Ttk.Ttk Ttk.TtkDialog)")))
                     (shell-command-to-string
                      (format "python2.6 ~/elisp/p-m/emacs.py c %s" symbol))))
             (error nil)
             )))
      (sort
       ;; We can get duplicates from the above -- don't know why.
       (delete-dups completions)
       #'string<)
      )))

(defun my-python-complete-symbol ()
  "Perform completion on the Python symbol preceding point.
Repeating the command scrolls the completion window."
  (interactive)
  (let ((window (get-buffer-window "*Completions*")))
    (if (and (eq last-command this-command)
             (window-live-p window) (window-buffer window)
             (buffer-name (window-buffer window)))
        (with-current-buffer (window-buffer window)
          (if (pos-visible-in-window-p (point-max) window)
              (set-window-start window (point-min))
            (save-selected-window
              (select-window window)
              (scroll-up))))
      ;; Do completion.
      (let* ((end (point))
             (symbol (python-partial-symbol))
             (completions (python-symbol-completions symbol))
             (completion (if completions 
                             (try-completion symbol completions)
                           )))
        (when symbol
          (cond ((eq completion t))
                ((null completion)
                 (message "Can't find completion for \"%s\"" symbol)
                 (ding))
                ((not (string= symbol completion))
                 (delete-region (- end (length symbol)) end)
                 (insert completion))
                (t
                 (message "Making completion list...")
                 (with-output-to-temp-buffer "*Completions*"
                   (display-completion-list completions symbol))
                 (message "Making completion list...%s" "done"))))))))