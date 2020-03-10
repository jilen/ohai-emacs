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


(use-package eglot
  :config
  (defclass eglot-vls (eglot-lsp-server) ()
    :documentation "Vue Language Server.")

  (add-to-list 'eglot-server-programs
               '(vue-mode . (eglot-vls . ("vls" "--stdio")))
               )

  (cl-defmethod eglot-initialization-options ((server eglot-vls))
    "Passes through required vetur initialization options to VLS."
    '())
  )

(with-eval-after-load 'flycheck
  (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))
  (flycheck-add-mode 'javascript-eslint 'vue-mode))



(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))

(provide 'ohai-vue)

;;; ohai-vue.el ends here
