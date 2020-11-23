;;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; THEME
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-hard t))

;;; JS2 MODE
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
;;; js2-refactor and xref-js2
(require 'js2-refactor)
(require 'xref-js2)

;;; backup configs

(setq backup-directory-alist '(("" . "~/.emacs.d/saves/per-save")))

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs.d/saves/per-session")))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)

;;; some configs too
(scroll-bar-mode -1)
(global-hl-line-mode +1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(delete-selection-mode t)
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(org-agenda-files '("~/org-roam/20201122222112-format.org"))
 '(package-selected-packages
   '(helm outshine org-roam projectile xref-js2 js2-refactor js2-mode))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

			        


(load "~/.emacs.d/lisp/buffer-move")
; S - x load-file Ret ~/.emacs.d/lisp/buffer-move.el
					; buf-move-left/right/top/down
(global-set-key (kbd "<C-right>") 'windmove-right)
(global-set-key (kbd "<C-left>") 'windmove-left)
(global-set-key (kbd "<C-up>") 'windmove-up)
(global-set-key (kbd "<C-down>") 'windmove-down)

(global-set-key (kbd "<M-right>") 'buf-move-right)
(global-set-key (kbd "<M-left>") 'buf-move-left)
(global-set-key (kbd "<M-up>") 'buf-move-up)
(global-set-key (kbd "<M-down>") 'buf-move-down)

;;; org-roam settings
(setq org-roam-directory "~/org-roam")
(add-hook 'after-init-hook 'org-roam-mode)
(require 'org-roam-protocol)

;;; projectile settings
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))



;;; page-break lines
(load "~/.emacs.d/lisp/page-break-lines")
(global-page-break-lines-mode)

;;; org-roam good outliners
(load "~/.emacs.d/lisp/org-bullets")
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;;; helm configs
(use-package helm
  :ensure t
  :config (helm-mode 1))


;;; all-the icons
(add-to-list 'load-path "~/.emacs.d/lisp/all-the-icons")
(require 'all-the-icons)

(insert (all-the-icons-icon-for-file "\\.\\"))


;;; dashboard
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-dashboard")
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq org-agenda-include-diary t)



