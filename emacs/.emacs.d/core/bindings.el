;; Global Utilities  -*- lexical-binding: t;-*-
(require 'utils)

(global-set-key (kbd "C-c e") 'open-emacs-config)
(global-set-key (kbd "C-c k b") 'open-emacs-keybind)
(global-set-key (kbd "C-c p") 'open-emacs-packages)
;; Tab Bar
(global-set-key (kbd "C-{") 'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "C-}") 'tab-bar-switch-to-next-tab)
(global-set-key (kbd "C-t") 'tab-bar-new-tab)
(global-set-key (kbd "C-S-w") 'tab-bar-close-tab)

;; Multiple Cursors & Editing
(global-set-key (kbd "M-m") 'mc/mark-next-like-this)
(global-set-key (kbd "C-x r y") 'yank-rectangle)

;; Consult
(with-eval-after-load 'consult
  (define-key global-map (kbd "C-x b")   'consult-buffer)
  (define-key global-map (kbd "C-x 4 b") 'consult-buffer-other-window)
  (define-key global-map (kbd "C-x 5 b") 'consult-buffer-other-frame)
  (define-key global-map (kbd "C-x r b") 'consult-bookmark)
  (define-key global-map (kbd "C-x r x") 'consult-register)
  (define-key global-map (kbd "C-s")     'consult-line)
  (define-key global-map (kbd "M-y")     'consult-yank-pop)
  (define-key global-map (kbd "s-s")     'consult-line-multi)
  (define-key global-map (kbd "s-f")     'consult-ripgrep)
  (define-key global-map (kbd "s-g")     'consult-grep)  
  (define-key global-map (kbd "C-h i")   'consult-info)
  (define-key global-map (kbd "C-c m")   'consult-mode-command)
  (define-key global-map (kbd "C-c k l")   'consult-keep-lines))

;; Windmove (Super + hjkl)
(with-eval-after-load 'windmove
  (global-set-key (kbd "s-h") 'windmove-left)
  (global-set-key (kbd "s-j") 'windmove-down)
  (global-set-key (kbd "s-k") 'windmove-up)
  (global-set-key (kbd "s-l") 'windmove-right))

;; Buffer Move
(with-eval-after-load 'buffer-move
  (global-set-key (kbd "<C-s-up>")    'buf-move-up)
  (global-set-key (kbd "<C-s-down>")  'buf-move-down)
  (global-set-key (kbd "<C-s-left>")  'buf-move-left)
  (global-set-key (kbd "<C-s-right>") 'buf-move-right))
(keymap-global-set "C-c r" 'consult-recent-file)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  ;; Optional: If you want TAB to be the only way to select
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection))
(provide 'bindings)
