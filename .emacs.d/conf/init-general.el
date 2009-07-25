; detect OS
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))

(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin
  (equal system-type 'cygwin))

(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))

(defvar run-darwin (equal system-type 'darwin))

;; eval-safe
;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
(defmacro eval-safe (&rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

(eval-when-compile
  (require 'cl))

; req
(require 'flymake)
(require 'smart-compile)

; ack
(custom-set-variables '(grep-program "ack -H -a --nogroup"))

; smart-compile
(defvar smart-compile-alist '(
  ("\\.c\\'"          . "gcc %f -lm -o %n")
  ("\\.[Cc]+[Pp]*\\'" . "g++ %f -lm -o %n")
  ("\\.java\\'"       . "javac %f")
  ("\\.f90\\'"        . "f90 %f -o %n")
  ("\\.[Ff]\\'"       . "f77 %f -o %n")
  ("\\.tex\\'"        . (tex-file))
  ("\\.pl\\'"         . "perl -cw %f")
  (emacs-lisp-mode    . (emacs-lisp-byte-compile))
) "...")

(global-set-key "\C-cc" 'smart-compile)

;; ;; set global
;; ;(load "term/bobcat")
(global-set-key [delete] 'delete-char)
(global-set-key [backspace] 'delete-backward-char)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-o" 'next-multiframe-window)

;; no tab
(setq-default indent-tabs-mode nil)

;; colored space
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-1 '((t (:background "dark turquoise"))) nil)
(defface my-face-b-2 '((t (:background "cyan"))) nil)
(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
    (font-lock-add-keywords
        major-mode
            '(
                ("　" 0 my-face-b-1 append)
                ("\t" 0 my-face-b-2 append)
                ("[ ]+$" 0 my-face-u-1 append)
    )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
    (if font-lock-mode
        nil
    (font-lock-mode t))))

;; no bar
(tool-bar-mode nil)
(menu-bar-mode nil)
(set-scroll-bar-mode nil)

;; no bell
;; (setq visible-bell t)
(setq ring-bell-function 'ignore)

;; show paren, line, column
(show-paren-mode 1)
(line-number-mode t)
(column-number-mode t)

;; display time
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)

; for programming
(defun electric-pair ()
  "Insert character pair without surronding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

; backup
;; (setq make-backup-files t)
;; (setq backup-directory "~/.bak")
;; (if (and (boundp 'backup-directory)
;;          (not (fboundp 'make-backup-file-name-original)))
;;     (progn
;;       (fset 'make-backup-file-name-original
;;             (symbol-function 'make-backup-file-name))
;;       (defun make-backup-file-name (filename)
;;         (if (file-directory-p (expand-file-name backup-directory))
;;             (concat (expand-file-name backup-directory) 
;;                     "/" (file-name-nondirectory filename))
;;           (make-backup-file-name-original filename)))))

(setq inhibit-startup-message t)

; change-mode
(defun diff-with-original (ediff)
  "Examin diff of current buffer with original file.
        If with prefix, do interactive merge using `ediff-with-original'. "
  (interactive "P")
  (if ediff
      (ediff-with-original)
    ;; simple diff view with diff-mode
    (require 'ediff)
    (let ((diff-buf (get-buffer-create (format "*diff %s*" (buffer-file-name))))
          (ediff-diff-options "-u") ;; is it your favourite?
          (tmpfile (ediff-make-temp-file (current-buffer))))
      (save-excursion
        (set-buffer diff-buf)
        (setq buffer-read-only nil)
        (buffer-disable-undo)
        (erase-buffer))
      (ediff-make-diff2-buffer diff-buf
                               (buffer-file-name)
                               tmpfile)
      (delete-file tmpfile)
      (set-buffer diff-buf)
      (if (< (buffer-size) 1)
          (message "No differences with original file.")
        (condition-case nil
            (progn
              (require 'diff-mode)
              (diff-mode))
          (error))
        (goto-char 1)
        (pop-to-buffer diff-buf)))))

(defun ediff-with-original ()
  (interactive)
  ;; interactive merge using ediff
  (let ((file buffer-file-name)
        (buf (current-buffer))
        (orig-buf (get-buffer-create (concat "*orig " buffer-file-name "*"))))
    (set-buffer orig-buf)
    (setq buffer-read-only nil)
    (buffer-disable-undo)
    (erase-buffer)
    (insert-file file)
    (setq buffer-read-only t)
    (set-buffer-modified-p nil)
    (ediff-buffers orig-buf buf)))
