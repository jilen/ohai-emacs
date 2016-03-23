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
  (interactive)
  "Compile the sbt project."
  (when
      (comint-check-proc (sbt:buffer-name))
    (sbt-command "test:compile")))


;;; Sbt settings
(add-hook 'sbt-mode-hook
          '(lambda ()
             (setq compilation-skip-threshold 1)
             (local-set-key (kbd "C-a") 'comint-bol)
             (local-set-key (kbd "M-RET") 'comint-accumulate)))

(add-hook 'scala-mode-hook
          '(lambda() (local-set-key (kbd "C-c b") 'compile-sbt-project)))

(provide 'ohai-scala)
;;; Enable compile on save

;;; ohai-scala.el ends here
