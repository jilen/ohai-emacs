;;; ohai-kotlin.el --- Kotlin support

;;; Commentary:
;;

(use-package kotlin-mode
  :config
  (require 'ohai-eglot)
  (add-hook 'kotlin-mode-hook 'eglot-ensure))


(provide 'ohai-kotlin)

;;; ohai-kotlin.el ends here
