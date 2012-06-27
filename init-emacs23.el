(cua-mode t)
(transient-mark-mode 1)
(global-font-lock-mode t)
(menu-bar-mode -1)
(setq header-line-format mode-line-format mode-line-format nil)

; powerline
; (load "~/.emacs.d/powerline.el")
; (load "~/.emacs.d/powerline-major.el")

; git-blame
; (load "~/.emacs.d/git-blame.el")
; (require 'git-blame)

; yaml-mode
; (load "~/.emacs.d/yaml-mode/yaml-mode.el")
; (require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

; css-mode for less
; (add-to-list 'auto-mode-alist '("\\.less$" . css-mode))

; JS2 Mode
; (load "~/.emacs.d/js2.el")
(add-to-list 'load-path "~/.emacs.d/js2/")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js-indent-level 2
      js2-basic-offset 2)

; Ruby Mode
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
;(defun set-reindent-then-newline-and-indent ()
;  (interactive)
;  (local-set-key (kbd "RET") 'reindent-then-newline-and-indent))

(add-hook 'ruby-mode-hook 'set-reindent-then-newline-and-indent)

;; Make shifted direction keys work on the Linux console or in an xterm
(when (member (getenv "TERM") '("linux" "xterm"))
  (dolist (prefix '("\eO" "\eO1;" "\e[1;"))
    (dolist (m '(("2" . "S-") ("3" . "M-") ("4" . "S-M-") ("5" . "C-")
                 ("6" . "S-C-") ("7" . "C-M-") ("8" . "S-C-M-")))
      (dolist (k '(("A" . "<up>") ("B" . "<down>") ("C" . "<right>")
                   ("D" . "<left>") ("H" . "<home>") ("F" . "<end>")))
        (define-key function-key-map
                    (concat prefix (car m) (car k))
                    (read-kbd-macro (concat (cdr m) (cdr k))))))))

; Editor Settings
(setq default-tab-width 2) ; how many spaces should my tab be?
(setq-default indent-tabs-mode nil)
; (global-hl-line-mode t) ; Highlight the current line
; (set-face-background 'hl-line "#EFEFEF") ; Customize highlight bg color
(blink-cursor-mode t)
(show-paren-mode t) ;; see the matching parens
(setq-default indent-tabs-mode nil) ;; no tabs, space only
(set-default 'truncate-lines t)
(setq ido-enable-flex-matching t)
(setq shift-select-mode t)
(setq visual-line-mode t)
(global-linum-mode t)
(setq linum-format "%d ")

; nxml (HTML ERB template support)
; (load "~/.emacs.d/nxhtml/autostart.el")
; (setq
;   nxhtml-global-minor-mode t
;   mumamo-chunk-coloring 'submode-colored
;   nxhtml-skip-welcome t
;   indent-region-mode t
;   rng-nxml-auto-validate-flag nil
;   nxml-degraded t)
; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))

; Rinari
; (add-to-list 'load-path "~/.emacs.d/rinari")
; (require 'rinari)
; (setq rinari-tags-file-name "TAGS")

;; rhtml-mode
; (add-to-list 'load-path "~/.emacs.d/rhtml")
; (require 'rhtml-mode)
; (add-hook 'rhtml-mode-hook
;    (lambda () (rinari-launch)))

; Color Theme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
; (eval-after-load "color-theme"
;  '(progn
;     (load-library "color-theme-ir-black")
;     (load-library "color-theme-solarized")
;     (load-library "color-theme-railscasts")
(color-theme-initialize)
; (color-theme-ir-black)
(color-theme-zenburn)
;     ))
(set-cursor-color "DarkGoldenrod")

;; nuke trailing whitespaces when writing to a file
; (add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; very nice completey stuff
(ido-mode t)

(defalias 'list-buffers 'ibuffer) ;; overrides defaults
(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key [(shift return)] 'insert-empty-line)

(defun ge()
  "Open the .emacs dir"
  (interactive)
  (find-file "~/.emacs.d"))

(defun insert-empty-line ()
  "Add a newline after current line, and move cursor to newline"
  (interactive)
  (move-end-of-line nil)
  (open-line 1)
  (next-line 1)
  (indent-according-to-mode))

(defun duplicate-line()
  "Duplicates current line"
  (interactive)
  (kill-whole-line)
  (yank)(yank))

; Andrew's fancy ido-file-jumping thing
(defun ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (cond
   ((not symbol-list)
    (let ((ido-mode ido-mode)
          (ido-enable-flex-matching
           (if (boundp 'ido-enable-flex-matching)
               ido-enable-flex-matching t))
          name-and-pos symbol-names position)
      (unless ido-mode
        (ido-mode 1)
        (setq ido-enable-flex-matching t))
      (while (progn
               (imenu--cleanup)
               (setq imenu--index-alist nil)
               (ido-goto-symbol (imenu--make-index-alist))
               (setq selected-symbol
                     (ido-completing-read "Symbol? " symbol-names))
               (string= (car imenu--rescan-item) selected-symbol)))
      (unless (and (boundp 'mark-active) mark-active)
        (push-mark nil t nil))
      (setq position (cdr (assoc selected-symbol name-and-pos)))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position)))))
   ((listp symbol-list)
    (dolist (symbol symbol-list)
      (let (name position)
        (cond
         ((and (listp symbol) (imenu--subalist-p symbol))
          (ido-goto-symbol symbol))
         ((listp symbol)
          (setq name (car symbol))
          (setq position (cdr symbol)))
         ((stringp symbol)
          (setq name symbol)
          (setq position
                (get-text-property 1 'org-imenu-marker symbol))))
        (unless (or (null position) (null name)
                    (string= (car imenu--rescan-item) name))
          (add-to-list 'symbol-names name)
          (add-to-list 'name-and-pos (cons name position))))))))
     (global-set-key "\C-ci" 'ido-goto-symbol)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ruby-deep-arglist nil)
 '(ruby-deep-indent-paren nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
