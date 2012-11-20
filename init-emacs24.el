(cua-mode t)
(transient-mark-mode 1)
(global-font-lock-mode t)
(menu-bar-mode -1)
(setq header-line-format mode-line-format mode-line-format nil)
(ido-mode t)

(require 'linum)
(global-linum-mode)
(setq linum-format "%d ")

; php-mode
(add-to-list 'load-path "~/.emacs.d/php-mode")
(require 'php-mode)

; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
   (lambda () (rinari-launch)))

; color themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)

; editor settings
(setq default-tab-width 2) ; how many spaces should my tab be?
(setq-default indent-tabs-mode nil)
(set-default 'truncate-lines t)
(setq ido-enable-flex-matching t)

; start with blank buffer
(setf inhibit-splash-screen t)
(switch-to-buffer (get-buffer-create "empty"))
(delete-other-windows)

; Put autosave files in their place!
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

; (server-start)
