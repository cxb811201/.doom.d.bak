;;; my/org/config.el -*- lexical-binding: t; -*-

(after! org
  (setq org-latex-pdf-process '("xelatex -interaction nonstopmode -output-directory %o %f" "xelatex -interaction nonstopmode -output-directory %o %f")))

(use-package! valign
  :config
  (after! org
    (add-hook! 'org-mode-hook :append
      ;; (display-line-numbers-mode -1)
      ;; (org-indent-mode -1)
      (valign-mode +1))))
