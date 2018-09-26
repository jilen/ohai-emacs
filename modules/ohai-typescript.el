;;; ohai-typescript.el --- tide

;;; Commentary:
;;

;;; Code:

(use-package typescript-mode)

(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(provide 'ohai-typescript)

;;; ohai-typescript.el ends here
