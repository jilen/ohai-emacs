;;; -*- lexical-binding: t -*-
;;; ohai-javascript.el --- Everybody's favourite personal hell.

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
(require 'ohai-lib)
(require 'ohai-json)

;; If npm is installed, add its local prefix to the executable
;; search path, which helps Emacs find linters etc.
;; This isn't Windows compatible, but then neither is npm, really.
(-when-let (npm-prefix (ohai/exec-if-exec "npm" "config get prefix"))
  (setenv "PATH" (concat npm-prefix "/bin:" (getenv "PATH"))))

;; Install js2-mode, which improves on Emacs's default JS mode
;; tremendously.
(use-package js2-mode
  :mode (("\\.js$" . js2-mode)
         ("\\.es6\\'" . js2-mode)
         ("\\.ejs\\'" . js2-mode))
  :interpreter "node"
  :commands js2-mode
  )

(use-package lsp-mode
  :config
  (eval-after-load 'js-mode
            '(add-hook 'js-mode-hook #'lsp))
  (eval-after-load 'js2-mode
    '(add-hook 'js2-mode-hook #'lsp))
  )

(use-package add-node-modules-path
  :config
  (eval-after-load 'js-mode
            '(add-hook 'js-mode-hook #'add-node-modules-path))
  (eval-after-load 'js2-mode
    '(add-hook 'js2-mode-hook #'add-node-modules-path))
)



(provide 'ohai-javascript)
