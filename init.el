(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'better-defaults)
(setq visible-bell nil)
(setq inhibit-startup-message t)

(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(eval-after-load 'ess-s-l '(progn (ess-toggle-underscore t)
				  (ess-toggle-underscore nil)))

(set-face-attribute 'mode-line nil :box nil)

(ido-mode t)
(global-evil-surround-mode 1)

(setq-default truncate-lines t)
