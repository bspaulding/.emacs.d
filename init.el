(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(setq backup-directory-alist
  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t)))

(setq exec-path-from-shell-arguments '("-l"))
(exec-path-from-shell-initialize)

(require 'evil)
(require 'evil-leader)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "bd" 'kill-buffer
  "f" 'projectile-find-file;;'fzf
  "i" 'escreen-goto-prev-screen
  "o" 'escreen-goto-next-screen
  "p" 'prettier-js
  "t" 'projectile-toggle-between-implementation-and-test;;'open-test-in-split
  "w" 'save-buffer
  "q" 'save-buffers-kill-emacs)
(define-key evil-visual-state-map "gc" 'comment-or-uncomment-region)
(global-evil-leader-mode)
(require 'evil-surround)
(global-evil-surround-mode)
(evil-mode 1)
(require 'evil-magit)

(global-linum-mode t)
(require 'linum-relative)
(linum-relative-on)

(editorconfig-mode 1)
(scroll-bar-mode -1)

(projectile-mode 1)
(projectile-register-project-type 'npm '("package.json")
  :compile "yarn install"
  :test "yarn test"
  :run "yarn start"
  :test-suffix ".test")

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(load "escreen")
(escreen-install)

(setq-default truncate-lines t)

(set-frame-font "-*-Fira Code-normal-normal-normal-*-18-*-*-*-m-0-iso10646-1")

(require 'color-theme)
(color-theme-initialize)
(add-to-list 'load-path "~/source/solarized/emacs-colors-solarized")
(require 'color-theme-solarized)
(color-theme-solarized-dark)

(require 'nvm)
(nvm-use "v6.11.3")

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(require 'prettier-js)
(add-hook 'web-mode-hook 'prettier-js-mode)

;; weird stuff to make fzf.el work
(setq fzf/args "--no-hscroll --margin=0,1,1,0 --print-query")
(require 'subr-x)

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

(require 'flycheck)
(setq flycheck-checkers
  (remove 'javascript-jscs
    (remove 'javascript-jshint
      (remove 'javascript-standard flycheck-checkers))))
(add-hook 'after-init-hook #'global-flycheck-mode)

(defun open-test-in-split ()
 "Open corresponding test file in a split on the left."
 (interactive)
 (split-window-horizontally)
 (find-file
  (concat
    (substring
      (buffer-file-name)
      0
      (- (length (buffer-file-name)) 2))
    "test.js")))

(require 'parinfer)
(setq parinfer-extensions '(defaults evil))
(add-hook 'clojure-mode-hook #'parinfer-mode)
(add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
(add-hook 'common-lisp-mode-hook #'parinfer-mode)
(add-hook 'scheme-mode-hook #'parinfer-mode)
(add-hook 'lisp-mode-hook #'parinfer-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(package-selected-packages
     (quote
       (flx-ido evil-surround flycheck jss projectile escreen tabbar nvm prettier-js evil-magit magit exec-path-from-shell ag swift-mode web-mode linum-relative editorconfig-charset-extras color-theme parinfer goto-last-change fzf evil-leader editorconfig cider)))
 '(tool-bar-mode nil))
(custom-set-faces)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
