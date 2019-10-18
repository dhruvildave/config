;;;
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
 '(blink-cursor-mode nil)
 '(c-default-style
   (quote
    ((java-mode . "java")
     (awk-mode . "awk")
     (other . "stroustrup"))))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(delete-selection-mode nil)
 '(delete-trailing-lines t)
 '(display-line-numbers-type (quote relative))
 '(electric-pair-mode t)
 '(global-auto-revert-mode t)
 '(global-display-line-numbers-mode t)
 '(org-ascii-indented-line-width 4)
 '(org-edit-src-content-indentation 4)
 '(org-indent-indentation-per-level 4)
 '(org-src-preserve-indentation t)
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (tide elpy company-irony-c-headers winring company-irony irony better-defaults)))
 '(python-indent-guess-indent-offset nil)
 '(python-shell-interpreter "python3")
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python3")
 '(require-final-newline (quote visit-save))
 '(show-paren-mode t)
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-indent-on-newline t)
 '(verilog-auto-lineup (quote ignore))
 '(verilog-case-indent 4)
 '(verilog-cexp-indent 4)
 '(verilog-compiler "/usr/bin/iverilog")
 '(verilog-indent-level 4)
 '(verilog-indent-level-behavioral 4)
 '(verilog-indent-level-declaration 4)
 '(verilog-indent-level-module 4))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

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
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;(mapc #'(lambda (package)
;  (unless (package-installed-p package)
;    (package-install package)))
;     myPackages)

;; (elpy-enable)

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
;; (load-theme 'monokai t)
;; (load-theme 'solarized-dark t)

;; TypeScript Setup
;(defun setup-tide-mode ()
;  (interactive)
;  (tide-setup)
;  (flycheck-mode +1)
;  (setq flycheck-check-syntax-automatically '(save mode-enabled))
;  (eldoc-mode +1)
;  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
;  (company-mode +1))

;; aligns annotation to the right hand side
;(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;(add-hook 'before-save-hook 'tide-format-before-save)

;(add-hook 'typescript-mode-hook #'setup-tide-mode)
