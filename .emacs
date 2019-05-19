;; dhruvil
;; Sun 19 May 2019 02:37:29 PM IST
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(c-default-style
   (quote
    ((java-mode . "java")
     (awk-mode . "awk")
     (other . "stroustrup"))))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(display-line-numbers-type (quote relative))
 '(electric-pair-mode t)
 '(global-display-line-numbers-mode t)
 '(org-indent-indentation-per-level 4)
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (solarized-theme
     zenburn-theme
     dracula-theme
     one-themes
     constant-theme
     elpy
     company-irony-c-headers
     winring
     company-irony
     irony
     material-theme
     better-defaults)))
 '(python-indent-guess-indent-offset nil)
 '(python-shell-interpreter "python3")
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python3")
 '(require-final-newline (quote visit-save))
 '(show-paren-mode t))

(setq inhibit-startup-message t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; (defvar myPackages
;; '(better-defaults
;;   elpy
;;   material-theme
;;   zenburn-theme
;;   dracula-theme
;;   monokai-theme
;;   constant-theme
;;   one-themes))

;; (mapc #'(lambda (package)
;;	  (unless (package-installed-p package)
;;	    (package-install package)))
;;      myPackages)

(elpy-enable)

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 4)
        (setq python-indent-offset 4)))

;; (load-theme 'constant t)
;; (load-theme 'constant-light 0)
;; (load-theme 'one-dark t)
;; (load-theme 'dracula t)
;; (load-theme 'zenburn t)
;; (load-theme 'material t)
(load-theme 'monokai t)
;; (load-theme 'solarized-dark t)
