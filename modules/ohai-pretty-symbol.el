;;; ohai-pretty-symbol.el --- Pretty symbol setup

;;; Commentary:
;;
;;; Code:

(defun my-correct-symbol-bounds (pretty-alist)
  "Prepend a TAB character to each symbol in this alist,
this way compose-region called by prettify-symbols-mode
will use the correct width of the symbols
instead of the width measured by char-width."
  (mapcar (lambda (el)
            (setcdr el (string ?\t (cdr el)))
            el)
          pretty-alist))

(defun my-ligature-list (ligatures codepoint-start)
  "Create an alist of strings to replace with
codepoints starting from codepoint-start."
  (let ((codepoints (-iterate '1+ codepoint-start (length ligatures))))
    (-zip-pair ligatures codepoints)))

(setq exclude-ligatures '("[]"))

(setq fira-code-ligatures
      (let* ((ligs '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
                     "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
                     "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
                     "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
                     ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
                     "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
                     "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
                     "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
                     ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
                     "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
                     "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
                     "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
                     "x" ":" "+" "+" "*")))
        (my-correct-symbol-bounds (my-ligature-list ligs #Xe100))))

(defun active-ligs()
    (seq-remove (lambda (pair) (member (car pair) exclude-ligatures)) fira-code-ligatures)
    )

(defun set-fira-code-ligatures ()
  "Add hasklig ligatures for use with prettify-symbols-mode."
  (setq prettify-symbols-alist
        (append (active-ligs) prettify-symbols-alist))
  (prettify-symbols-mode))

(add-hook 'prog-mode-hook 'set-fira-code-ligatures)

(provide 'ohai-pretty-symbol)

;;; ohai-pretty-symbol.el ends here
