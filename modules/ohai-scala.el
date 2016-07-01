;;; ohai-scala.el --- Ohai scala support

;;; Commentary:
;; Bring scala development related modes

;;; Code:
(require 'ohai-lib)


(use-package scala-mode
  :init
  (define-derived-mode sbt-build-mode scala-mode ".sbt build file major mode")
  (add-to-list 'auto-mode-alist '("\\.sbt\\'" . sbt-build-mode))
  :config
  (when (ohai/resolve-exec "drip") (setenv "JAVACMD" "drip"))
  (use-package sbt-mode
    :config
    (defun compile-sbt-project ()
      (interactive)
      "Compile the sbt project."
      (when
          (comint-check-proc (sbt:buffer-name))
        (sbt-command "test:compile")))))

(global-set-key (kbd "C-c b") 'compile-sbt-project)
(provide 'ohai-scala)
;;; Enable compile on save

;;; ohai-scala.el ends here
