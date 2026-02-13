;;; --- UI & Appearance ---
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)

(setq inhibit-startup-screen t)
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
;(add-to-list 'default-frame-alist '(undecorated . t))
(setq split-height-threshold nil)
(setq split-width-threshold 80)
(setq use-short-answers t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Space-line
(use-package spaceline :ensure t
  :config
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main)))
		powerline-default-separator 'wave
		))
(use-package spaceline-config :ensure spaceline
  :config
  (powerline-center-theme))


;; Theme configuration
(add-to-list 'custom-theme-load-path "~/.emacs.d/exten/")

(setq adwaita-dark-theme-bold-vertico-current t)
(load-theme 'adwaita-dark t)



;; --- Package infrastructure ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(defvar my/packages
  '(ac-html auto-sudoedit beacon buffer-move company-c-headers
	     ido-at-point ido-complete-space-or-hyphen
	     ido-completing-read+ ido-grid-mode magit org-autolist
	     smex vterm))

(require 'cl-lib)

(defun my/install-packages ()
  "Ensure the packages I use are installed. See `my/packages'."
  (interactive)
  (let ((missing-packages (cl-remove-if #'package-installed-p my/packages)))
    (when missing-packages
      (message "Installing %d missing package(s)" (length missing-packages))
      (package-refresh-contents)
      (mapc #'package-install missing-packages))))

(my/install-packages)
;; Beacon
(beacon-mode t)

;;; --- Completion System (Ido & Smex) ---
(ido-mode 1)
(ido-everywhere 1)
(ido-grid-mode 1)

(use-package ido-completing-read+
  :ensure t
  :config (ido-ubiquitous-mode 1))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))

;;; --- Navigation & Windows ---

;; Tab Bar Settings
(tab-bar-mode 1)
(setq tab-bar-close-button-show nil)         ;; Hide X button
(setq tab-bar-new-tab-choice "*dashboard*")  ;; Default buffer
(setq tab-bar-tab-hints t)                   ;; Show numbers
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))

(global-set-key (kbd "C-{") 'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "C-}") 'tab-bar-switch-to-next-tab)
(global-set-key (kbd "C-t") 'tab-bar-new-tab)
(global-set-key (kbd "C-S-w") 'tab-bar-close-tab)

;; Windmove (Window Switching)
(use-package windmove
  :ensure t
  :demand t
  :config
  (windmove-default-keybindings '(shift meta))
  (setq windmove-wrap-around t)
  (setq windmove-allow-all-windows t)
  (windmove-mode 1))

;; Buffer Move (Window Content Swapping)
(setq x-super-keysym 'hyper) ; Map Windows Key to Hyper

(use-package buffer-move
  :ensure t
  :bind (("<C-H-up>"    . buf-move-up)
         ("<C-H-down>"  . buf-move-down)
         ("<C-H-left>"  . buf-move-left)
         ("<C-H-right>" . buf-move-right)))
;;; Org-mode
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))  (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))

(use-package org-latex-preview
  :config
  ;; Increase preview width
  (plist-put org-latex-preview-appearance-options
             :page-width 0.8)
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-latex-preview-process-default 'dvisvgm)
  
  (add-hook 'org-mode-hook 'org-latex-preview-mode)

  ;; ;; Block C-n, C-p etc from opening up previews when using `org-latex-preview-mode'
  ;; (setq org-latex-preview-mode-ignored-commands
  ;;       '(next-line previous-line mwheel-scroll
  ;;         scroll-up-command scroll-down-command))

  ;; ;; Enable consistent equation numbering
  ;; (setq org-latex-preview-numbered t)

  
  (setq org-latex-preview-mode-display-live t)

  ;; More immediate live-previews -- the default delay is 1 second
  (setq org-latex-preview-mode-update-delay 0.25))

;;; Save-file
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

';;languages
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'load-path "~/.emacs.d/languages/")

(require 'c-hook)



;;; --- Automatically Generated Custom Section ---
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(adwaita-dark-theme-gray-outlines t)
 '(adwaita-dark-theme-no-completions-first-difference t)
 '(custom-enabled-themes '(adwaita-dark))
 '(custom-safe-themes
   '("74df3ebf39ecfbae335a791703992249c39a2d3c3997b73cf210ddce78671813"
     default))
 '(inhibit-startup-buffer-menu nil)
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(ac-html auto-sudoedit beacon buffer-move company-c-headers
	     ido-at-point ido-complete-space-or-hyphen
	     ido-completing-read+ ido-grid-mode laas magit
	     math-symbol-lists multiple-cursors neotree org-autolist
	     smex spaceline vterm)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
(global-set-key (kbd "<f5>") (lambda () 
                               (interactive)
                               (disable-theme 'adwaita-dark) ; replace with your theme name
                               (load-theme 'adwaita-dark t)
                               (message "Theme reloaded!")))
