;;; ohai-php.el --- Php support for ohai

;;; Commentary:
;; Setup for php programming language
;;; Code:

(defun ohai-php-mode-init ()
  (setq c-basic-offset 2))

(use-package php-mode
  :hook
  ((php-mode . ohai-php-mode-init)))

(provide 'ohai-php)

;;; ohai-php.el ends here
