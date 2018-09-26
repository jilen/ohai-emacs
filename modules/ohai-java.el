;;; ohai-java.el --- Lsp java

;;; Commentary:
;;

(defcustom eclipse-jdt-ls--dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/server/")
  "jdt-ls location"
  :type 'string
  :group 'ohai-java)

(defun detect-equinox-launcher () (car (directory-files (concat eclipse-jdt-ls--dir "plugins") t "org.eclipse.equinox.launcher_.*.jar$")))

(defun eclipse-jdt-ls--opt () `(
                              "-Declipse.application=org.eclipse.jdt.ls.core.id1"
                              "-Dosgi.bundles.defaultStartLevel=4"
                              "-Declipse.product=org.eclipse.jdt.ls.core.product"
                              "-Dlog.level=ALL"
                              "-noverify"
                              "-Xmx1G"
                              "--add-opens"
                              "java.base/java.util=ALL-UNNAMED"
                              "--add-opens"
                              "java.base/java.lang=ALL-UNNAMED"
                              "--add-modules=ALL-SYSTEM"
                              "-jar"
                              ,(detect-equinox-launcher)
                              "-configuration"
                              ,(concat eclipse-jdt-ls--dir "config_linux")
                              "-data"
                              ,(concat (getenv "HOME") "/Workspace")))


(defun eclipse-jdt-ls--cmd () `("java" . ,(eclipse-jdt-ls--opt)))


(use-package eglot
  :config
  (add-to-list 'eglot-server-programs `(java-mode . ,(eclipse-jdt-ls--cmd)))
  )

(provide 'ohai-java)

;;; ohai-java.el ends here
