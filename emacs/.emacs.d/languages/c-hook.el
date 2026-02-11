(require 'eglot)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-or-c++-mode-hook 'eglot-ensure)

(provide 'c-hook)
