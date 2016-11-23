;;; ohai-restclient.el --- RestClient config

;;; Commentary:
;;

(use-package restclient
  :mode ("\\.http\\'" . restclient-mode)
  :config
  (require 'restclient))

(provide 'ohai-restclient)

;;; ohai-restclient.el ends here
