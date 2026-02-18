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

(add-hook 'emacs-startup-hook (lambda () (delete-other-windows)) t)
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(setq adwaita-dark-theme-bold-vertico-current t)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(delete-selection-mode t)

;; Theme & Modeline
(add-to-list 'custom-theme-load-path "~/.emacs.d/exten/")
(load-theme 'adwaita-dark t)
(setq adwaita-dark-theme-bold-vertico-current t)

;;; --- Completion System ---
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;;; --- Navigation & Windows ---
(setq dired-dwim-target t
      dired-listing-switches "-al --group-directories-first"
      dired-recursive-copies 'always
      dired-recursive-deletes 'always)

(tab-bar-mode 1)
(setq tab-bar-show 1
      tab-bar-close-button-show nil
      tab-bar-new-tab-choice "*scratch*"
      tab-bar-tab-hints t
      tab-bar-separator " | "
      tab-bar-format '(tab-bar-format-tabs tab-bar-separator))

(custom-set-faces
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

;;; --- System & File Handling ---
(setq backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      initial-buffer-choice (lambda () (calendar) (diary-mark-entries) (get-buffer "*Calendar*")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

