(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq show-paren-delay 0)
(require 'better-defaults)
(setq visible-bell nil)
(setq inhibit-startup-message t)

(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(eval-after-load 'ess-s-l '(progn (ess-toggle-underscore t)
				  (ess-toggle-underscore nil)))
(require 'ess)
(require 'ess-inf)

(require 'zenburn-theme)

(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

(ido-mode t)
(global-evil-surround-mode 1)

(setq-default truncate-lines t)

(require 'evil-exchange)
(evil-exchange-install)

(evilnc-default-hotkeys)

(require 'evil-args)
;; bind evil-args text objects
(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

;; bind evil-forward/backward-args
(define-key evil-normal-state-map "L" 'evil-forward-arg)
(define-key evil-normal-state-map "H" 'evil-backward-arg)
(define-key evil-motion-state-map "L" 'evil-forward-arg)
(define-key evil-motion-state-map "H" 'evil-backward-arg)

;; bind evil-jump-out-args
(define-key evil-normal-state-map "K" 'evil-jump-out-args)

(require 'linum-relative)
(global-linum-mode)

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
    (message "Renamed to %s." new-name)))

(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'cycle-buffer)

;; '(define-minor-mode site-keys-mode
;;   "Site key map"
;;   :keymap
;;   '(([C-p] . cycle-buffer-permissive)))

;; '(site-keys-mode t)
;; '(add-to-list 'emulation-mode-map-alists '((site-keys . site-keys-map)))

;; '(defvar site-keys-mode-map-alist '((site-keys-mode . site-keys-mode-map)))

;; '(setq emulation-mode-map-alists '(site-keys-mode-map-alist))

(define-key evil-normal-state-map (kbd "C-p") nil)
(global-set-key (kbd "C-p") 'cycle-buffer-permissive)
