(add-to-list 'load-path "~/.emacs.d/lisp")

(setq temporary-file-directory "~/.emacs.d/tmp/")


;; Settings
(defvar settings-dir
  (expand-file-name "settings" "~/.emacs.d/"))
(add-to-list 'load-path settings-dir)


(require 'my-package)

(defvar local-packages '(projectile
                         helm
                         helm-swoop
                         helm-projectile
                         undo-tree
                         epc
                         company-jedi
                         company-quickhelp
                         company
                         better-defaults
                         elpy
                         py-isort
                         flycheck
                         recentf
                         material-theme
                         py-autopep8))

(defun uninstalled-packages (packages)
  (delq nil
	(mapcar (lambda (p) (if (package-installed-p p nil) nil p)) packages)))

;; This delightful bit adapted from:
;; http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/

(let ((need-to-install (uninstalled-packages local-packages)))
  (when need-to-install
    (progn
      (package-refresh-contents)
      (dolist (p need-to-install)
	(package-install p)))))

;; for latest versions of packages
(require 'cl)				; common lisp goodies, loop

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get
   ecb
   monky
   ahg
   restclient))


(el-get 'sync my:el-get-packages)

;; end of packaging

;; BASIC CUSTOMIZATION
;; --------------------------------------

(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)


(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material-light t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path
   (quote
    (("/" "/")
     ("/srv/websites/frontend-new" "frontend")
     (#("/srv/websites/backoffice" 0 24
        (help-echo "Mouse-2 toggles maximizing, mouse-3 displays a popup-menu"))
      "backoffice"))))
 '(enable-local-variables :all)
 '(inhibit-startup-screen t)
 '(python-shell-interpreter "python")
 '(whitespace-line-column 120))

(require 'ecb)
(setq stack-trace-on-error t) ;;don’t popup Backtrace window
(setq ecb-tip-of-the-day nil)
(setq ecb-auto-activate t)
;;(setq ecb-layout-name "left6")



(savehist-mode t)

(require 'my_javascript)
(require 'my_python)
(require 'my_grep)

(add-to-list 'company-backends 'company-dabbrev t)

(column-number-mode t)

(require 'undo-tree)
(global-undo-tree-mode 1)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(require 'helm)
(require 'helm-config)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x b") #'helm-mini)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "M-y") #'helm-show-kill-ring)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode t)
(setq ring-bell-function 'ignore)
