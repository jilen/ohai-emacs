;;; ohai-vue.el --- Vue mode support

;;; Commentary:
;;
;;; Code:

(use-package web-mode)
(use-package add-node-modules-path)
(use-package flycheck)

(define-derived-mode vue-mode web-mode "Vue"
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0))

(flycheck-def-config-file-var flycheck-vue-tslint-config
    vue-tslint "tslint.json"
  :safe #'stringp
  :package-version '(flycheck . "27"))

(flycheck-def-config-file-var flycheck-vue-tslint-project
    vue-tslint "tsconfig.json"
  :safe #'stringp
  :package-version '(flycheck . "27"))


(flycheck-define-checker vue-tslint
  "TypeScript style checker using TSLint."
  :command ("vue-tslint"
            (config-file "-c" flycheck-vue-tslint-config)
            (config-file "-p" flycheck-vue-tslint-project)
            "-s" source-inplace)
  :error-parser flycheck-parse-tslint
  :modes (vue-mode))


(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(add-hook 'vue-mode-hook #'add-node-modules-path)

(provide 'ohai-vue)

;;; ohai-vue.el ends here
