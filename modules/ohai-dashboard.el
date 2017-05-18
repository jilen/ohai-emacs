;;; ohai-dashboard.el --- Dashboard setup

;;; Commentary:
;; Dashboard setup

;;; Code

(use-package dashboard :config
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)))
  (setq dashboard-startup-banner "~/.emacs.d/logo.png")
  (setq dashboard-banner-logo-title "Don't forget.\nAlways, somewhere. Someone is fighting for you.\nAs long as you remember her.\nYou are not alone.")
  (dashboard-setup-startup-hook))

(provide 'ohai-dashboard)

;;; ohai-dashboard.el ends here
