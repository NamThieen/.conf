;;; init.el -*- lexical-binding: t -*-
; from https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
(defvar gc-cons-threshold-original)
(defvar file-name-handler-alist-original)
(setq file-name-handler-alist-original file-name-handler-alist
      file-name-handler-alist nil
      gc-cons-threshold most-positive-fixnum)

(add-hook
 'after-init-hook
 (defun my-reset-some-hacks ()
   "Reset the effects some performance hacks to initial state."
   (setq file-name-handler-alist file-name-handler-alist-original)
   (setq gc-cons-threshold (* 16 1024 1024))))

(setq load-prefer-newer noninteractive)

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded in %s with %d garbage collections."
                     (emacs-init-time)
                     gcs-done)))

(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
(require 'bindings)
(require 'packages)

;;; --- UI & Appearance ---
(setq inhibit-startup-screen t
      use-short-answers t
      split-height-threshold nil
      split-width-threshold 80)
       
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
;(fido-vertical-mode 1)
(setq ring-bell-function 'ignore)
(setq visible-bell t)

(add-hook 'emacs-startup-hook (lambda () (delete-other-windows)) t)
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(setq adwaita-dark-theme-bold-vertico-current t)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(delete-selection-mode t)

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/exten/")
(load-theme 'adwaita-dark t)
(setq adwaita-dark-theme-bold-vertico-current t)

;;; --- Completion System ---
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;;; --- Navigation & Windows ---
(with-eval-after-load 'dired
  (eval-and-compile
    (require 'dired))
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (setq dired-dwim-target t
        dired-recursive-copies 'always
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        dired-kill-when-opening-new-dired-buffer t
        delete-by-moving-to-trash t
        dired-do-revert-buffer t)
  (put 'dired-jump 'repeat-map nil))

(tab-bar-mode 1)
(setq tab-bar-show 1
      tab-bar-close-button-show nil
      tab-bar-new-tab-choice "*scratch*"
      tab-bar-tab-hints t
      tab-bar-separator ""
      tab-bar-format '(tab-bar-format-tabs tab-bar-separator))

;;; --- Editing & Languages ---
(electric-pair-mode 1)
(show-paren-mode 1)
(editorconfig-mode 1)
(which-key-mode 1)
(savehist-mode t)
(save-place-mode t)
(recentf-mode t)

(add-to-list 'load-path "~/.emacs.d/languages/")
(ignore-errors (require 'c-hook))
(with-eval-after-load 'org
  (load "typst"))
;;; --- System & File Handling ---
(make-directory (expand-file-name "cache/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "cache/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "cache/auto-saves/" user-emacs-directory) t))
      backup-directory-alist `((".*" . ,temporary-file-directory))
      initial-buffer-choice (lambda () (calendar) (diary-mark-entries) (get-buffer "*Calendar*")))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d65d0e1e7468dd7464b2c3e9bcf1c68629bd2fc563549e37304574c383d82ea9"
     default))
 '(package-selected-packages
   '(buffer-move c-eval company consult magit marginalia multiple-cursors
		 orderless org-modern ox-typst rainbow-delimiters sly
		 typst-preview typst-ts-mode vertico vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
