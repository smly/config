; path
(add-to-load-path "~/.emacs.d/elisp/golang-mode")

; golang-mode
(require 'go-mode-load)

; indent ;p
(add-hook 'go-mode-hook
          '(lambda ()
             (setq tab-width 4)))

;; flymake for go
(defun flymake-go-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "6g" (list local-file))))
(add-hook
 'go-mode-hook
 '(lambda ()
    (if (not (null buffer-file-name)) (flymake-mode))))
(push '(".+\\.go$" flymake-go-init  flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
