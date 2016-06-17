;;; ohai-vue.el --- Vue mode support

;;; Commentary:
;;
(use-package web-mode
  :init
  (define-derived-mode vue-mode web-mode "vue mode simply alias web-mode")
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  :config
  (setq web-mode-content-types-alist
        '(("vue" . "\\.vue?$")))
  (with-eval-after-load "flycheck"
    (flycheck-add-mode 'javascript-eslint 'vue-mode)
    (setq flycheck-javascript-eslint-executable (or (ohai/resolve-exec "eslint") "eslint"))))

(provide 'ohai-vue)

;;; ohai-vue.el ends here
