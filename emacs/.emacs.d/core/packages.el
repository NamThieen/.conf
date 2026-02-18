;;; --- Package Infrastructure ---
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

(use-package company :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode) 
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

(use-package multiple-cursors :ensure t)

(use-package magit :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package c-eval :ensure t)

(use-package vterm :ensure t)

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
  :config
  (setq vertico-cycle t
        vertico-preselect 'directory)
;  (vertico-grid-mode)
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
  (completion-styles '(orderless))
  (completion-category-overrides
   '((file (styles orderless))))

  (orderless-component-separator 'orderless-escapable-split-on-space)
  (orderless-matching-styles
   '(orderless-literal
     orderless-prefixes
     orderless-initialism
     orderless-regexp
     orderless-flex
     ;; orderless-strict-leading-initialism
     ;; orderless-strict-initialism
     ;; orderless-strict-full-initialism
     ;; orderless-without-literal          ; Recommended for dispatches instead
     ))
  (orderless-style-dispatchers
   '(prot-orderless-literal-dispatcher
     prot-orderless-strict-initialism-dispatcher
     prot-orderless-flex-dispatcher))
  :init
  (defun orderless--strict-*-initialism (component &optional anchored)
    "Match a COMPONENT as a strict initialism, optionally ANCHORED.
The characters in COMPONENT must occur in the candidate in that
order at the beginning of subsequent words comprised of letters.
Only non-letters can be in between the words that start with the
initials.

If ANCHORED is `start' require that the first initial appear in
the first word of the candidate.  If ANCHORED is `both' require
that the first and last initials appear in the first and last
words of the candidate, respectively."
    (orderless--separated-by
        '(seq (zero-or-more alpha) word-end (zero-or-more (not alpha)))
      (cl-loop for char across component collect `(seq word-start ,char))
      (when anchored '(seq (group buffer-start) (zero-or-more (not alpha))))
      (when (eq anchored 'both)
        '(seq (zero-or-more alpha) word-end (zero-or-more (not alpha)) eol))))

  (defun orderless-strict-initialism (component)
    "Match a COMPONENT as a strict initialism.
This means the characters in COMPONENT must occur in the
candidate in that order at the beginning of subsequent words
comprised of letters.  Only non-letters can be in between the
words that start with the initials."
    (orderless--strict-*-initialism component))

  (defun prot-orderless-literal-dispatcher (pattern _index _total)
    "Literal style dispatcher using the equals sign as a suffix.
It matches PATTERN _INDEX and _TOTAL according to how Orderless
parses its input."
    (when (string-suffix-p "=" pattern)
      `(orderless-literal . ,(substring pattern 0 -1))))

  (defun prot-orderless-strict-initialism-dispatcher (pattern _index _total)
    "Leading initialism  dispatcher using the comma suffix.
It matches PATTERN _INDEX and _TOTAL according to how Orderless
parses its input."
    (when (string-suffix-p "," pattern)
      `(orderless-strict-initialism . ,(substring pattern 0 -1))))

  (defun prot-orderless-flex-dispatcher (pattern _index _total)
    "Flex  dispatcher using the tilde suffix.
It matches PATTERN _INDEX and _TOTAL according to how Orderless
parses its input."
    (when (string-suffix-p "." pattern)
      `(orderless-flex . ,(substring pattern 0 -1)))))

;;(use-package org
;;  :config
;;  (org-babel-do-load-languages 'org-babel-load-languages '((C . t)))
;;  (setq org-agenda-include-diary t)
;;  (plist-put org-latex-preview-appearance-options :page-width 0.8)
;;  (setq org-preview-latex-default-process 'dvisvgm
;;        org-latex-preview-process-default 'dvisvgm
;;        org-latex-preview-numbered t
;;        org-latex-preview-mode-display-live t
;;        org-latex-preview-mode-update-delay 0.25)
;;  (add-hook 'org-mode-hook 'org-latex-preview-mode))

(require 'bindings)
(provide 'packages)
