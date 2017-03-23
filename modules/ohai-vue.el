;;; ohai-vue.el --- Vue mode support

;;; Commentary:
;;

(use-package web-mode)
(use-package add-node-modules-path)


(define-derived-mode vue-mode web-mode "Vue"
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0))



(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))

(add-hook 'vue-mode-hook #'add-node-modules-path)

;; Flycheck settings
(with-eval-after-load "flycheck"
  (flycheck-add-mode 'javascript-eslint 'vue-mode))

;; Company setting


(provide 'ohai-vue)

;;; ohai-vue.el ends here
