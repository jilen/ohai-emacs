;;; ohai-dashboard.el --- Dashboard setup

;;; Commentary:
;; Dashboard setup

;;; Code
(add-to-list 'load-path (concat user-emacs-directory "dashboard/"))

(use-package page-break-lines)
(use-package projectile)
(require 'dashboard)
(dashboard-setup-startup-hook)
(provide 'ohai-dashboard)

;;; ohai-dashboard.el ends here
