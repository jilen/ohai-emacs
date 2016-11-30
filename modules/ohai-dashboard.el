;;; ohai-dashboard.el --- Dashboard setup

;;; Commentary:
;; Dashboard setup

;;; Code

(use-package dashboard :config
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)))
  (dashboard-setup-startup-hook))

(provide 'ohai-dashboard)

;;; ohai-dashboard.el ends here
