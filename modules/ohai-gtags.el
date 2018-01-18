;;; ohai-gtags.el --- GNU Global support

;;; Commentary:
;; Add GNU Global support

;;; Code:
(use-package counsel-gtags)

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun output-message-sentinel (process msg)
  ())

(defun gtags-update ()
  (interactive)
  "Make GTAGS incremental update"
  (set-process-sentinel (start-process "global" "gtags" "global" "-u") #'output-message-sentinel))

(defun gtags-update-hook ()
  (when (gtags-root-dir)
    (gtags-update)))

(add-hook 'after-save-hook #'gtags-update-hook)

(with-eval-after-load 'counsel-gtags
  (define-key counsel-gtags-mode-map (kbd "M-.") 'counsel-gtags-dwim)
  (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
  (define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
  (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
  (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward))

(setq prog-mode-hook
      '(lambda ()
         (counsel-gtags-mode 1)))



(provide 'ohai-gtags)

;;; ohai-gtags.el ends here
