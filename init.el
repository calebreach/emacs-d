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

(define-key evil-normal-state-map (kbd "C-p") nil)
(global-set-key (kbd "C-p") 'cycle-buffer-permissive)
(global-set-key (kbd "C-S-p") 'cycle-buffer-backward-permissive)

(define-key evil-motion-state-map (kbd "C-f") nil)
(global-set-key (kbd "C-f") 'find-file)

(define-key evil-motion-state-map (kbd "C-b") nil)
(global-set-key (kbd "C-b") 'switch-to-buffer)

(require 'paredit)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "S-<up>") 'backward-up-list)
(global-set-key (kbd "C-S-<up>") 'up-list)
(global-set-key (kbd "S-<down>") 'down-list)
(global-set-key (kbd "C-S-<down>") 'backward-down-list)
(global-set-key (kbd "C-S-<left>") 'backward-to-previous-sexp)
(global-set-key (kbd "C-S-<right>") 'forward-to-next-sexp)
(global-set-key (kbd "S-<left>") 'paredit-backward)
(global-set-key (kbd "S-<right>") 'paredit-forward)
(global-set-key (kbd "S-<delete>") 'kill-sexp)
(global-set-key (kbd "S-<backspace>") 'backward-kill-sexp)
(global-set-key (kbd "C-S-t") 'transpose-sexps)
(global-set-key (kbd "M-9") 'insert-parentheses)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "C-'") 'duplicate-line)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)

(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-S-<left>") 'winner-undo)
(global-set-key (kbd "M-S-<right>") 'winner-redo)

(define-key evil-normal-state-map (kbd "C-n") nil)
(global-set-key (kbd "C-n") 'save-buffer)

(setq cua-enable-cua-keys nil)
(cua-mode t)

(setq ac-fuzzy-cursor-color nil)

(setq default-frame-alist
  '((width . 170)
    (height . 55)
    (font . "Monaco-10")))

(server-start)
(autopair-global-mode t)
(global-auto-complete-mode t)
(setq ac-fuzzy-cursor-color nil)
(add-hook 'before-save-hook 'whitespace-cleanup)
