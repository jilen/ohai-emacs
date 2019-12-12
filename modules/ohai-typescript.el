;;; ohai-typescript.el --- tide

;;; Commentary:
;;

;;; Code:

(use-package lsp-mode)
(use-package add-node-modules-path)
(use-package typescript-mode
  :after (flycheck)
  :config
  (flycheck-add-mode 'javascript-eslint 'typescript-mode)
  (add-hook 'typescript-mode-hook #'lsp)

  :hook ((typescript-mode . add-node-modules-path))
  )

(use-package web-mode
  :after (flycheck)
  :hook ((web-mode . add-node-modules-path))
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (add-hook 'typescript-mode-hook #'lsp)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode)))



(provide 'ohai-typescript)

;;; ohai-typescript.el ends here
