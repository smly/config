;; init-switch.el
; iswitchb, anything, ido-mode

; InteractivelyDoThings
; ref. http://www.emacswiki.org/emacs/InteractivelyDoThings
;; C-d to enter dired.
;; C-l to run ido-reread-directory to refresh the current work directory.
;; C-f to return to normal find-file
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map [tab] 'ido-complete)))

; using ido programmatically
(defun my-icompleting-read(prompt choices)
  (let ((ido-make-buffer-list-hook
         (lambda ()
           (setq ido-temp-list choices))))
    (ido-read-buffer prompt)))

(global-set-key [?\C-;] 'ido-switch-buffer)

; iswitchb-mode
;; (iswitchb-mode t)

;; (add-hook 'iswitchb-define-mode-map-hook
;;           'iswitchb-my-keys)

;; (defun iswitchb-my-keys ()
;;   "Add my keybindings for iswitchb."
;;   (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
;;   (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
;;   (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
;;   (define-key iswitchb-mode-map " " 'iswitchb-next-match)
;;   (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
;;   )

;; (defadvice iswitchb-exhibit
;;   (after
;;    iswitchb-exhibit-with-display-buffer
;;    activate)
;;   (when (and
;;          (eq iswitchb-method iswitchb-default-method)
;;          iswitchb-matches)
;;     (select-window
;;      (get-buffer-window (cadr (buffer-list))))
;;     (let ((iswitchb-method 'samewindow))
;;       (iswitchb-visit-buffer
;;        (get-buffer (car iswitchb-matches))))
;;     (select-window (minibuffer-window))))

; (global-set-key [?\C-;] 'iswitchb-buffer)

; anything
; http://www.emacswiki.org/emacs/download/anything.el
; http://www.emacswiki.org/emacs/download/anything-config.el
;(require 'anything-config)

;; (setq anything-sources
;;       (list anything-c-source-buffers
;;             anything-c-source-bookmarks
;;             anything-c-source-file-name-history
;;             anything-c-source-man-pages
;;             anything-c-source-info-pages
;;             anything-c-source-calculation-result
;;             anything-c-source-locate))

;; (global-set-key "\C-xb" 'anything)
;; (anything-iswitchb-setup)

;; (define-key anything-map "\C-p" 'anything-previous-line)
;; (define-key anything-map "\C-n" 'anything-next-line)
;; (define-key anything-map "\C-v" 'anything-next-page)
;; (define-key anything-map "\M-v" 'anything-previous-page)
