;;; ohai-scala.el --- Ohai scala support

;;; Commentary:
;; Bring scala development related modes

;;; Code:

(require 'ohai-lib)

(use-package scala-mode
  :config
  (setq-default sbt:program-options '("-Djline.terminal=none" "-Dsbt.supershell=false"))
  (setq-default scala-indent:use-javadoc-style t))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config

  (add-hook 'sbt-mode-hook
            (lambda ()
              (setq prettify-symbols-alist
                    `((,(expand-file-name (directory-file-name default-directory)) . ?⌂)
                      (,(expand-file-name "~") . ?~)))
              (prettify-symbols-mode t)))

  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(defun sbt-compile ()
  "Compile sbt project."
  (interactive)
  (sbt-command "test:compile")
  )

(require 'sbt-mode-project)

(defun scalafmt (p)
  "Format specified file.  P is the file path."
  (shell-command (concat "scalafmt " p)))

(defun scalariform (c f)
  "Format specified file. C is the config, F is the file path."
  (shell-command (concat "scalariform -q " "--preferenceFile=" c " " f))
  )

(defun format-project ()
  "Format project."
  (interactive)
  (let (
        (default-directory (sbt:find-root))
        )
    (cond
     ((file-exists-p ".scalafmt.conf") (scalafmt (buffer-file-name (current-buffer))))
     ((file-exists-p ".scalariform.conf") (scalariform ".scalariform.conf" (buffer-file-name (current-buffer))))
     ))
  )

(defun sbt-test ()
  "Test current file."
  (interactive)
  (sbt-command (concat "testOnly " "*"
                       (file-name-base
                        (buffer-file-name
                         (current-buffer))))))

(use-package eglot)

(global-set-key (kbd "C-c b f") 'format-project)
(global-set-key (kbd "C-c b b") 'bloop-compile)
(global-set-key (kbd "C-c b t") 'bloop-test-only)

(define-derived-mode sbt-build-mode scala-mode ".sbt")
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . sbt-build-mode))
(require 'ohai-bloop)

(provide 'ohai-scala)

;;; ohai-scala.el ends here
