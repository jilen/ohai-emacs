;;; ohai-metals.el --- Support metals

;;; Commentary:
;;
;;; Code:


(defun find-sbt-prj (dir)
 "Try to locate a Rust project above DIR."
 (let ((found (locate-dominating-file dir "build.sbt")))
   (if (stringp found) `(transient . ,found) nil)))

(use-package eglot
  :init
  (add-hook 'project-find-functions 'find-sbt-prj nil nil)
  :config
  (add-to-list 'eglot-server-programs '(scala-mode . ("metals-emacs")))
  )

(provide 'ohai-metals)

;;; ohai-metals.el ends here
