(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(setenv "PATH" (concat "/usr/local/bin:/usr/texbin:" (getenv "PATH")))
(add-to-list 'exec-path "/usr/local/bin")

;; Packages
(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Better defaults
(setq show-paren-delay 0)
(require 'better-defaults)
(setq visible-bell nil)
(setq inhibit-startup-message t)

(ido-mode t)
(autopair-global-mode t)
(delete-selection-mode t)

(setq-default truncate-lines t)

(setq ac-fuzzy-cursor-color nil)
(global-auto-complete-mode t)

(defadvice ac-cleanup (around auto-complete-no-blink)
  "Don't blink the cursor when no matches are found"
  (let ((ac-cursor-color nil))
    ad-do-it))

(ad-activate 'ac-cleanup)

(setq default-frame-alist
  '((width . 170)
    (height . 55)
    (font . "Monaco-10")))

(server-start)

(add-hook 'before-save-hook 'whitespace-cleanup)

(require 'zenburn-theme)

(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

;; R
(eval-after-load 'ess-s-l '(progn (ess-toggle-underscore t)
          (ess-toggle-underscore nil)))
(require 'ess)
(require 'ess-inf)
(require 'ess-site)

(require 'cycle-buffer)

;; Libraries

(load-library "util")
(load-library "keys")
(load-library "auto-indent")
(load-library "site-lisp")
(load-library "site-latex")

(load-library "sakai-grader")
(put 'narrow-to-region 'disabled nil)
