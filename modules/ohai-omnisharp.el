;;; ohai-omnisharp.el --- CSharp Emacs dev


;;; Commentary:
;;

;;; Code:

(defun setup-charp ()
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode)

  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)

  ;csharp-mode README.md recommends this too
  ;(electric-pair-mode 1)       ;; Emacs 24
  ;(electric-pair-local-mode 1) ;; Emacs 25

  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  (local-set-key (kbd "C-c C-c") 'recompile))

(use-package omnisharp
  :config
  :hook
  (('charp-mode-hook #'omnisharp-mode)
   ('charp-mode-hook #'company-mode)
   ('charp-mode-hook #'flycheck-mode)
   ('charp-mode-hook 'setup-charp)
   ))



(add-hook 'csharp-mode-hook #'company-mode)

(provide 'ohai-omnisharp)

;;; ohai-omnisharp.el ends here
