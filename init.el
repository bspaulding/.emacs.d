;; Common Configuration

; Ruby Mode
(setq auto-mode-alist
      (append '(("\\.rake$" . ruby-mode)
                ("Rakefile$" . ruby-mode)
                ("\\.gemspec$" . ruby-mode)
                ("\\.ru$" . ruby-mode)
                ("Gemfile$" . ruby-mode))
      auto-mode-alist))

(if (< emacs-major-version 24)
    (load "~/.emacs.d/init-emacs23.el")
  (load "~/.emacs.d/init-emacs24.el"))
