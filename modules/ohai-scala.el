;;; ohai-scala.el --- Ohai scala support

;;; Commentary:
;; Bring scala development related modes

;;; Code:



(package-require 'scala-mode2)
(package-require 'sbt-mode)

(require 'scala-mode2)
(require 'sbt-mode)

(setq scala-indent:use-javadoc-style t)

;;; Compile current project
(defun compile-sbt-project ()
  "Compile the sbt project."
  (when
      (comint-check-proc (sbt:buffer-name))
    (sbt-command "test:compile")))

(add-hook 'scala-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'compile-sbt-project)))

;;; Sbt settings
(add-hook 'sbt-mode-hook
          '(lambda ()
             ;; compilation-skip-threshold tells the compilation minor-mode
             ;; which type of compiler output can be skipped. 1 = skip info
             ;; 2 = skip info and warnings.
             (setq compilation-skip-threshold 1)

             ;; Bind C-a to 'comint-bol when in sbt-mode. This will move the
             ;; cursor to just after prompt.
             (local-set-key (kbd "C-a") 'comint-bol)

             ;; Bind M-RET to 'comint-accumulate. This will allow you to add
             ;; more than one line to scala console prompt before sending it
             ;; for interpretation. It will keep your command history cleaner.
             (local-set-key (kbd "M-RET") 'comint-accumulate)
             ))

(add-hook
 'scala-mode-hook
 '(lambda ()
    ;; the definition of the thing at point.
    (local-set-key (kbd "M-.") 'sbt-find-definitions)

    ;; use sbt-run-previous-command to re-compile your code after changes
    (local-set-key (kbd "C-x '") 'sbt-run-previous-command)))

(provide 'ohai-scala)
;;; Enable compile on save

;;; ohai-scala.el ends here
