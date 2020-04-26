;;; ohai-centaur.el --- Centaur basic functions

;;; Commentary:
;; Utilities from Centaur Emacs
;;

;;; Code:

;; Emacs version
(defconst emacs/>=25p
  (>= emacs-major-version 25)
  "Emacs is 25 or above.")

(defconst emacs/>=26p
  (>= emacs-major-version 26)
  "Emacs is 26 or above.")

(defconst emacs/>=27p
  (>= emacs-major-version 27)
  "Emacs is 27 or above.")


(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst sys/linuxp
  (eq system-type 'gnu/linux)
  "Are we running on a GNU/Linux system?")

(defconst sys/macp
  (eq system-type 'darwin)
  "Are we running on a Mac system?")

(defconst sys/mac-x-p
  (and (display-graphic-p) sys/macp)
  "Are we running under X on a Mac system?")

(defconst sys/mac-cocoa-p
  (featurep 'cocoa)
  "Are we running with Cocoa on a Mac system?")

(defconst sys/linux-x-p
  (and (display-graphic-p) sys/linuxp)
  "Are we running under X on a GNU/Linux system?")

(defconst sys/cygwinp
  (eq system-type 'cygwin)
  "Are we running on a Cygwin system?")

(defconst sys/rootp
  (string-equal "root" (getenv "USER"))
  "Are you using ROOT user?")

;; Font
(defun font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))

;; Icon

(defun icons-displayable-p ()
  "Return non-nil if `all-the-icons' is displayable."
  (and t
       (display-graphic-p)
       (require 'all-the-icons nil t)))

(provide 'ohai-centaur)

;; Customization

(defcustom centaur-icon (display-graphic-p)
  "Display icons or not."
  :group 'centaur
  :type 'boolean)

;;; ohai-centaur.el ends here
