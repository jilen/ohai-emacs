;;; ohai-typescript.el --- tide

;;; Commentary:
;;

;;; Code:

(use-package typescript-mode)
(use-package add-node-modules-path)
(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . add-node-modules-path)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(provide 'ohai-typescript)

;;; ohai-typescript.el ends here
