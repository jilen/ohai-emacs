;;; ohai-scala.el --- Ohai scala support

;;; Commentary:
;; Bring scala development related modes

;;; Code:
(require 'ohai-lib)

(use-package scala-mode
  :config
  (setq-default scala-indent:use-javadoc-style t))




(use-package sbt-mode
  :commands sbt-start sbt-command
  :config

  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(require 'sbt-mode-project)

(defun scalafmt ()
  (interactive)
  (with-output-to-string
    (with-current-buffer
        standard-output
      (process-file shell-file-name nil '(t nil)  nil shell-command-switch "ng org.scalafmt.cli.Cli"))))


(defun format-project ()
  (interactive)
  (let (
        (default-directory (sbt:find-root)))
    (scalafmt)
    ))


(global-set-key (kbd "C-c b f") 'format-project)
(global-set-key (kbd "C-c b b") 'bloop-compile)
(global-set-key (kbd "C-c b r") 'bloop-compile-root)

(define-derived-mode sbt-build-mode scala-mode ".sbt")
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . sbt-build-mode))
(require 'ohai-bloop)
(provide 'ohai-scala)

;;; ohai-scala.el ends here
