;;; ohai-php.el --- Php support for ohai

;;; Commentary:
;; Setup for php programming language
;;; Code:

(package-require 'php-mode)

(add-hook 'php-mode-hook
          (lambda () (setq c-basic-offset 2)))
(provide 'ohai-php)

;;; ohai-php.el ends here
