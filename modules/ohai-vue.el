;;; ohai-vue.el --- Vue mode support

;;; Commentary:
;;
;;; Code:

(use-package web-mode)
(use-package add-node-modules-path)

(define-derived-mode vue-mode web-mode "Vue"
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0))

(add-hook 'vue-mode-hook #'add-node-modules-path)

(use-package lsp-mode
  :config
  (use-package lsp-ui :commands lsp-ui-mode)
  (use-package company-lsp :commands company-lsp)
  (use-package helm-lsp :commands helm-lsp-workspace-symbol)
  (add-hook 'vue-mode-hook #'lsp)
  :commands (lsp lsp-deferred))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'vue-mode))



(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))

(provide 'ohai-vue)

;;; ohai-vue.el ends here
