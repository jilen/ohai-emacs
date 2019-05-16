;;; ohai-kotlin.el --- Kotlin support

;;; Commentary:
;;

(use-package eglot)
(use-package kotlin-mode
  :config
  (setq-default kotlin-tab-width 4)
  (add-hook 'kotlin-mode-hook 'eglot-ensure))


(provide 'ohai-kotlin)

;;; ohai-kotlin.el ends here
