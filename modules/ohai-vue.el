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

(add-hook 'vue-mode-hook #'add-node-modules-path)

(defun flycheck-parse-vue-tslint (output checker buffer)
  "Parse TSLint errors from JSON OUTPUT.

CHECKER and BUFFER denoted the CHECKER that returned OUTPUT and
the BUFFER that was checked respectively.

See URL `https://palantir.github.io/tslint/' for more information
about TSLint."
  (let ((json-array-type 'list))
    (seq-map (lambda (message)
               (let-alist message
                 (flycheck-error-new-at
                  (+ 1 .startPosition.line)
                  (+ 1 .startPosition.character)
                  'warning .failure
                  :id .ruleName
                  :checker checker
                  :buffer buffer
                  :filename .name)))
             ;; Don't try to parse empty output as JSON
             (and (not (string-empty-p output))
                  (car (flycheck-parse-json output))))))

(defun flycheck-vue--find-working-directory (_checker)
  "Look for a working directory to run ESLint CHECKER in.

This will be the directory that contains the `node_modules'
directory.  If no such directory is found in the directory
hierarchy, it looks first for `.eslintignore' and then for
`.eslintrc' files to detect the project root."
  (let* ((regex-config (concat "\\`\\tslint"
                               "\\(\\.\\(js\\|ya?ml\\|json\\)\\)?\\'")))
    (when buffer-file-name
      (or (locate-dominating-file buffer-file-name "node_modules")
          (locate-dominating-file
           (file-name-directory buffer-file-name)
           (lambda (directory)
             (> (length (directory-files directory nil regex-config t)) 0)))))))
(flycheck-define-checker vue-tslint
  "TypeScript style checker using TSLint."
  :command ("vue-tslint" "-c" "tslint.json" source-inplace)
  :working-directory flycheck-vue--find-working-directory
  :error-parser flycheck-parse-vue-tslint
  :modes vue-mode)

(use-package eglot
  :config
  (defclass eglot-vls (eglot-lsp-server) ()
    :documentation "Vue Language Server.")

  (add-to-list 'eglot-server-programs
               '(vue-mode . (eglot-vls . ("vls" "--stdio"))))

  (cl-defmethod eglot-initialization-options ((server eglot-vls))
    "Passes through required vetur initialization options to VLS."
    '(:vetur
      (:completion
       (:autoImport t :useScaffoldSnippets t :tagCasing "kebab")
       :grammar
       (:customBlocks
        (:docs "md" :i18n "json"))
       :validation
       (:template t :style t :script t)
       :format
       (:options
        (:tabSize 2 :useTabs :json-false)
        :defaultFormatter
        (:html "prettyhtml" :css "prettier" :postcss "prettier" :scss "prettier" :less "prettier" :stylus "stylus-supremacy" :js "prettier" :ts "prettier")
        :defaultFormatterOptions
        (:js-beautify-html
         (:wrap_attributes "force-expand-multiline")
         :prettyhtml
         (:printWidth 100 :singleQuote :json-false :wrapAttributes :json-false :sortAttributes :json-false))
        :styleInitialIndent :json-false :scriptInitialIndent :json-false)
       :trace
       (:server "verbose")
       :dev
       (:vlsPath ""))
      ))
  )


(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(add-to-list 'flycheck-checkers 'vue-tslint)

(provide 'ohai-vue)

;;; ohai-vue.el ends here
