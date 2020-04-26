;;; ohai-omnisharp.el --- CSharp Emacs dev


;;; Commentary:
;;

;;; Code:


(use-package csharp-mode)

(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))

(defun my-csharp-mode-setup ()
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
   ('charp-mode-hook #'my-csharp-mode-setup)))



(add-hook 'csharp-mode-hook #'company-mode)

(provide 'ohai-omnisharp)

;;; ohai-omnisharp.el ends here
