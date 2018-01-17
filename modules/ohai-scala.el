;;; ohai-scala.el --- Ohai scala support

;;; Commentary:
;; Bring scala development related modes

;;; Code:
(require 'ohai-lib)

(defun format-file(file)
  "format current file use scalafmt"
  (let ((config-file (expand-file-name (concat (sbt:find-root) ".scalariform.conf" ))))
    (shell-command (concat "ng scalariform.commandline.Main  --preferenceFile=" config-file " " file " >/dev/null")))
  )

(defun format-buffer-file()
  (interactive)
  "format current buffer file"
  (format-file (buffer-file-name (current-buffer)))
  (revert-buffer t t))

(use-package scala-mode
  :bind (("C-c C-f" . format-buffer-file))
  :config
  (setq-default scala-indent:use-javadoc-style t))

(define-derived-mode sbt-build-mode scala-mode ".sbt")
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . sbt-build-mode))


(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(defun compile-sbt-project ()
      (interactive)
      "Compile the sbt project."
      (when
          (comint-check-proc (sbt:buffer-name))
        (sbt-command "test:compile")))
;;(use-package helm-gtags)

(global-set-key (kbd "C-c b") 'compile-sbt-project)
(provide 'ohai-scala)

;;; ohai-scala.el ends here
