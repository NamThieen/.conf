;;; --- Package Infrastructure ---  -*- lexical-binding: t;-*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (bound-and-true-p package--initialized)
  (package-initialize))
(unless package-archive-contents
  (package-refresh-contents))

;; This ensures use-package itself is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure nil)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode) 
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

(use-package multiple-cursors
  :ensure t)

(use-package magit
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package c-eval
  :ensure t)

(use-package vterm
  :ensure t)

(use-package windmove
  :config
  (setq windmove-wrap-around t))

(use-package buffer-move :ensure t)

(use-package consult
  :ensure t
  :config (setq consult-narrow-key "<"))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)) 

(use-package vertico
  :ensure t
  :init
  (vertico-mode t)
  (defvar +vertico-current-arrow t)

  (cl-defmethod vertico--format-candidate :around
    (cand prefix suffix index start &context ((and +vertico-current-arrow
                                                   (not (bound-and-true-p vertico-flat-mode)))
                                              (eql t)))
    (setq cand (cl-call-next-method cand prefix suffix index start))
    (if (bound-and-true-p vertico-grid-mode)
	(if (= vertico--index index)
            (concat #("▶" 0 1 (face vertico-current)) cand)
          (concat #("_" 0 1 (display " ")) cand))
      (if (= vertico--index index)
         (concat
           #(" " 0 1 (display (left-fringe right-triangle vertico-current)))
           cand)
	cand)))
  (defvar +vertico-transform-functions nil)

  (cl-defmethod vertico--format-candidate :around
    (cand prefix suffix index start &context ((not +vertico-transform-functions) null))
    (dolist (fun (ensure-list +vertico-transform-functions))
      (setq cand (funcall fun cand)))
    (cl-call-next-method cand prefix suffix index start))

  (defun +vertico-highlight-directory (file)
    "If FILE ends with a slash, highlight it as a directory."
    (if (string-suffix-p "/" file)
	(propertize file 'face 'dired-directory) ; or face 'dired-directory
      file))

  ;; function to highlight enabled modes similar to counsel-M-x
  (defun +vertico-highlight-enabled-mode (cmd)
    "If MODE is enabled, highlight it as font-lock-constant-face."
    (let ((sym (intern cmd)))
      (if (or (eq sym major-mode)
              (and
               (memq sym minor-mode-list)
               (boundp sym)))
	  (propertize cmd 'face 'font-lock-constant-face)
	cmd)))
  :config
  (setq vertico-cycle t
	vertico-preselect 'directory)
  (vertico-multiform-mode 1)

  ;; add-to-list works if 'file isn't already in the alist
  ;; setq can be used but will overwrite all existing values
  (add-to-list 'vertico-multiform-categories
               '(file
		 ;; this is also defined in the wiki, uncomment if used
		 ;; (vertico-sort-function . vertico-sort-directories-first)
		 (+vertico-transform-functions . +vertico-highlight-directory)))
  (add-to-list 'vertico-multiform-commands
               '(execute-extended-command
		 reverse
		 (+vertico-transform-functions . +vertico-highlight-enabled-mode)))
  
  :bind (:map vertico-map
              ("C-n" . vertico-next)
              ("C-i" . vertico-quick-insert)
              ("C-o" . vertico-quick-exit)
              ("C-p" . vertico-previous)
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)
              ("/" . (lambda () (interactive)
                       (if (file-directory-p (vertico--candidate))
                       (vertico-insert)
                     (self-insert-command 1 ?/))))))
(use-package marginalia
  :ensure t
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :custom
  (marginalia-align 'right)
  :init
  (marginalia-mode))

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic substring partial-completion flex))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package org-modern
  :ensure t
  :defer t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-star '("●" "○" "•" "◦"))
  (org-modern-list '((?- . "❯")
                     (?+ . "➤")
                     (?* . "➥")))
  (org-modern-todo nil))
(use-package typst-ts-mode
  :ensure nil
  :custom
  (typst-ts-mode-watch-options "--open"))
(require 'bindings)
(provide 'packages)
