;;; ohai-vue.el --- Vue mode support

;;; Commentary:
;;

(use-package web-mode
  :init
  (define-derived-mode vue-mode web-mode "vue mode simply alias web-mode")
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0)
  :config
  ;;; auto-complete-setup
  (with-eval-after-load "flycheck"
    (flycheck-add-mode 'javascript-eslint 'vue-mode)
    (setq flycheck-javascript-eslint-executable (or (ohai/resolve-exec "eslint") "eslint")))

  (with-eval-after-load "auto-complete"
    (use-package ac-html
      :config
      (setq web-mode-ac-sources-alist
            '(("html" . ())
              ("css" . (ac-source-css-property ac-source-words-in-buffer)))))

    (add-to-list 'ac-modes 'vue-mode)))

(provide 'ohai-vue)

;;; ohai-vue.el ends here
