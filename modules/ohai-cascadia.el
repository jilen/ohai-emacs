 (defun my-correct-symbol-bounds (pretty-alist)
    "Prepend a TAB character to each symbol in this alist,
this way compose-region called by prettify-symbols-mode
will use the correct width of the symbols
instead of the width measured by char-width."
    (mapcar (lambda (el)
              (setcdr el (string ?\t (cdr el)))
              el)
            pretty-alist))

  (defun cascadia-ligature-list (ligatures codepoint-start)
    "Create an alist of strings to replace with
codepoints starting from codepoint-start."
    (let ((codepoints (-iterate '1+ codepoint-start (length ligatures))))
      (-zip-pair ligatures codepoints)))



(setq cascadia-ligatures
      (let* ((ligs '("x" "www" "*" ":" "-" "--" "---" "-->" "-|" "->"
                     "->>" "--<" "-<<" "-~" "{|" ")#" "[|" "]#" "[|" "]#"
                     "..." "..=" "..<" ".?" ".=" "::" ":::" "::=" ":=" ":>"
                     ":<" ";;" "!!" "!!." "!=" "!==" "?." "?:" "??" "?="
                     "**" "***" "*>" "*/" "#(" "#{" "#[" "#:" "#!" "#?"
                     "##" "###" "####" "#=" "#_" "#_(" "/*" "/=" "/==" "/>"
                     "//" "///" "_|_" "__" "+" "@" "&&" "|-" "|}" "|]"
                     "||" "|||>" "||=" "||>" "|=" "|>" "$>" "++" "+++" "+>"
                     "=:=" "=!=" "==" "===" "==>" "=>" "=>>" "=<<" "=/=" ">-"
                     ">->" ">:" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<-" "<--"
                     "<->" "<-<" "<:" "<!--" "<*" "<*>" "<|" "<||" "<|||" "<|>"
                     "<$" "<$>" "<+" "<+>" "<=" "<==" "<==>" "<=>" "<=<" "<>"
                     "<<" "<<-" "<<=" "<<<" "<~" "<~>" "<~~" "</" "</>" "~-"
                     "~@" "~=" "~>" "~~" "~~>" "^=" "%%")))
      (my-correct-symbol-bounds (cascadia-ligature-list ligs #Xe100))))

  ;; nice glyphs for haskell with hasklig
  (defun set-cascadia-ligatures ()
    "Add hasklig ligatures for use with prettify-symbols-mode."
    (set-fontset-font t '(#Xe100 . #Xe189) "Cascadia Emacs")
    (setq prettify-symbols-alist
          (append cascadia-ligatures prettify-symbols-alist))
    (prettify-symbols-mode))


(add-hook 'prog-mode-hook #'set-cascadia-ligatures)

(provide 'ohai-cascadia)
;;; ohai-cascadia.el ends here
