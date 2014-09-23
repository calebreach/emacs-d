(setq reftex-plug-into-AUCTeX t)

(definit LaTeX
  (visual-line-mode t)
  (flyspell-mode t)
  (set-kbd-keys
    ("C-S-r" . preview-at-point)))

(defun LaTeX-env-document (&optional ignore)
  "Create new LaTeX document.
The compatibility argument IGNORE is ignored."
  (TeX-insert-macro "documentclass")
  (LaTeX-newline)
  (insert "\\author{Caleb Reach}")
  (LaTeX-newline)
  (TeX-insert-macro "title")
  (end-of-line)
  (LaTeX-newline)
  (end-of-line 0)
  (LaTeX-newline)
  (LaTeX-insert-environment "document")
  (run-hooks 'LaTeX-document-style-hook)
  (setq LaTeX-document-style-hook nil))

(require 'auctex-latexmk)
(auctex-latexmk-setup)
