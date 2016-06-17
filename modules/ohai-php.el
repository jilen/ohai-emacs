;;; ohai-php.el --- Php support for ohai

;;; Commentary:
;; Setup for php programming language
;;; Code:

(defvar php-electric-pairs '((?\{ . ?\})) "Electric pairs for php-mode.")

(defun ohai-php-mode-init ()
  (setq c-basic-offset 2)
  (setq-local electric-pair-pairs (append electric-pair-pairs php-electric-pairs))
  (setq-local electric-pair-text-pairs electric-pair-pairs))

(use-package php-mode
  :config
  (add-hook 'php-mode-hook 'ohai-php-mode-init))

(provide 'ohai-php)

;;; ohai-php.el ends here
