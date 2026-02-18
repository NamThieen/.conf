(defun open-emacs-config ()
  (interactive)
  (find-file "~/.conf/emacs/.emacs.d/init.el"))

(defun open-emacs-keybind ()
  (interactive)
  (find-file "~/.conf/emacs/.emacs.d/core/bindings.el"))

(defun open-emacs-packages ()
  (interactive)
  (find-file "~/.conf/emacs/.emacs.d/core/packages.el"))
(provide 'utils)
