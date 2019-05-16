;;; ohai-metals.el --- Support metals

;;; Commentary:
;;
;;; Code:

(defun find-sbt-prj (dir)
  "Try to locate a Rust project above DIR."
  (let ((found (locate-dominating-file dir "build.sbt")))
    (if (stringp found) `(transient . ,found) nil)))

(defun eglot-scala-hook ()
  (add-hook 'project-find-functions 'find-sbt-prj nil nil)
  )
(require 'ohai-scala)
(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
)
(use-package eglot
  :demand t
  :config
  (add-to-list 'eglot-server-programs '(scala-mode . ("metals-emacs")))
  :config
  (add-hook 'scala-mode-hook #'eglot-scala-hook))

;; (use-package flycheck
;;   :init (global-flycheck-mode))

;; (use-package lsp-mode
;;  :init (setq lsp-prefer-flymake nil))

;; (use-package lsp-ui)
;; (use-package company-lsp)

;; (use-package lsp-scala
;;   :after scala-mode
;;   :demand t
;;   ;; Optional - enable lsp-scala automatically in scala files
;;   )


(provide 'ohai-metals)

;;; ohai-metals.el ends here
