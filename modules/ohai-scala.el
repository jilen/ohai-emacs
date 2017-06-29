;;; ohai-scala.el --- Ohai scala support

;;; Commentary:
;; Bring scala development related modes

;;; Code:
(require 'ohai-lib)

(use-package scala-mode
  :init
  :config
  (setq-default scala-indent:use-javadoc-style t)
  (use-package sbt-mode
    :config
    (defun compile-sbt-project ()
      (interactive)
      "Compile the sbt project."
      (when
          (comint-check-proc (sbt:buffer-name))
        (sbt-command "test:compile")))))


(define-derived-mode sbt-build-mode scala-mode ".sbt")
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . sbt-build-mode))

;;(use-package helm-gtags)

(global-set-key (kbd "C-c b") 'compile-sbt-project)
(provide 'ohai-scala)

;;; ohai-scala.el ends here
