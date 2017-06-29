;;; ohai-ac.el --- Auto-complete mode for emacs

;;; Commentary:
;;
(use-package auto-complete
  :config
  (require 'auto-complete)
  (ac-config-default)
  (global-auto-complete-mode t)
  (setq ac-auto-show-menu t))

(provide 'ohai-ac)

;;; ohai-ac.el ends here
