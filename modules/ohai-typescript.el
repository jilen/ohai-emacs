;;; ohai-typescript.el --- tide

;;; Commentary:
;;

;;; Code:

(use-package add-node-modules-path)
(use-package typescript-mode
  :after (flycheck)
  :config (flycheck-add-mode 'javascript-eslint 'typescript-mode)
  :hook ((typescript-mode . add-node-modules-path))
  )

(use-package web-mode
  :after (flycheck)
  :hook ((web-mode . add-node-modules-path))
  :config
  ;; enable typescript-tslint checker
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  )


(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(web-mode . ("javascript-typescript-stdio")))
  )

(provide 'ohai-typescript)

;;; ohai-typescript.el ends here
