(cua-mode t)
(transient-mark-mode 1)
(global-font-lock-mode t)
(menu-bar-mode -1)
(setq header-line-format mode-line-format mode-line-format nil)
(ido-mode t)
(global-linum-mode t)
(setq linum-format "%d ")

; color themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)

; editor settings
(setq default-tab-width 2) ; how many spaces should my tab be?
(setq-default indent-tabs-mode nil)
(set-default 'truncate-lines t)
(setq ido-enable-flex-matching t)

; (server-start)
