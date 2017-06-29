;;; ohai-gtags.el --- GNU Global support

;;; Commentary:
;; Add GNU Global support

;;; Code:
(use-package helm-gtags)

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))
(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil nil nil "-u"))
(defun gtags-update-hook ()
  (when (gtags-root-dir)
    (gtags-update)))
(add-hook 'after-save-hook #'gtags-update-hook)


(global-set-key (kbd "M-;") 'helm-gtags-find-tag-from-here)   ;; M-; cycles to next result, after doing M-. C-M-. or C-M-,
(global-set-key (kbd "M-.") 'helm-gtags-find-tag) ;; M-. finds tag
(global-set-key [(control meta .)] 'helm-gtags-find-rtag)   ;; C-M-. find all references of tag
(global-set-key [(control meta \,)] 'helm-gtags-find-symbol) ;; C-M-, find all usages of symbol.
(setq prog-mode-hook
      '(lambda ()
         (helm-gtags-mode 1)))



(provide 'ohai-gtags)

;;; ohai-gtags.el ends here
