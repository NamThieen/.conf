;;; --- UI & Appearance ---
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)

(setq inhibit-startup-screen t)
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(add-to-list 'default-frame-alist '(undecorated . t))
(setq split-height-threshold nil)
(setq split-width-threshold 80)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
;; Beacon
(beacon-mode t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Theme configuration
(add-to-list 'custom-theme-load-path "~/.emacs.d/exten/")
(load-theme 'adwaita-dark t)

;;; --- Package Infrastructure ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Ensure use-package is available
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

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


;;; --- Automatically Generated Custom Section ---
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(adwaita-dark))
 '(custom-safe-themes
   '("74df3ebf39ecfbae335a791703992249c39a2d3c3997b73cf210ddce78671813"
     default))
 '(inhibit-startup-buffer-menu nil)
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(ac-html beacon ido-at-point ido-complete-space-or-hyphen
	     ido-completing-read+ ido-grid-mode magit
	     shr-tag-pre-highlight smex vterm web-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
