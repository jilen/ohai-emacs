;;; -*- lexical-binding: t -*-
;;; ohai-orgmode.el --- Your personal everything manager.

;; Copyright (C) 2015 Bodil Stokke

;; Author: Bodil Stokke <bodil@bodil.org>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'ohai-package)

(use-package org
  :ensure org-plus-contrib
  :config
   (setq org-latex-pdf-process
        '("xelatex --shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex --shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex --shell-escape -interaction nonstopmode -output-directory %o %f"))

  (use-package graphviz-dot-mode
    :config
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((dot . t)))
    (setq org-plantuml-jar-path (expand-file-name "~/.local/share/plantuml/plantuml.jar"))
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((plantuml . t))))
  ;; Stop org-mode from highjacking shift-cursor keys.
  (setq org-replace-disputed-keys t)
  ;; Always use visual-line-mode in org-mode, and wrap it at column 80.
  (add-hook
   'org-mode-hook
   (lambda ()
     (visual-line-mode 1)
     (set-visual-wrap-column 80)))
  ;; Fancy bullet rendering.
  (use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
  ;; Insert links from clipboard.
  (use-package org-cliplink
    :config
    (with-eval-after-load "org"
      (define-key org-mode-map (kbd "C-c M-l") 'org-cliplink))))



  (provide 'ohai-orgmode)
