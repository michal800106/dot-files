
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
   monky
   leuven-theme
   ahg))


(el-get 'sync my:el-get-packages)

;; end of packaging

;; BASIC CUSTOMIZATION
;; --------------------------------------

(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)


(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'leuven t) ;; load material theme
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
 '(elpy-syntax-check-command "/home/michalz/tmp/py37/bin/flake8")
 '(enable-local-variables :all)
 '(inhibit-startup-screen t)
 '(jedi:environment-virtualenv (quote py37))
 '(jedi:server-command
   (quote
    ("/home/michalz/.emacs.d/.python-environments/py37/bin/jediepcserver")))
 '(org-confirm-babel-evaluate nil)
 '(org-log-done (quote note))
 '(org-src-fontify-natively t)
 '(org-src-tab-acts-natively t)
 '(package-selected-packages
   (quote
    (mpdel dante flycheck-mypy flow-minor-mode web-mode isortify kubernetes magit magit-popup vdiff-magit string-inflection anaconda-mode company-anaconda jedi-core helm helm-ack helm-ag helm-bbdb helm-company helm-directory helm-dired-history helm-flycheck helm-git helm-ispell helm-ls-git helm-pydoc toml-mode blacken ensime scala-mode scad-mode scad-preview adoc-mode mustache mustache-mode esh-autosuggest eshell-git-prompt eshell-up eshell-z fish-completion markdownfmt mkdown vmd-mode company-go go-guru go-impl go-imports go-mode go-projectile gorepl-mode govet rats hlint-refactor haskell-snippets yasnippet yasnippet-snippets intero helm-systemd systemd ob-http ob-rust ob-restclient mmm-mode company-edbi edbi-database-url edbi-sqlite edbi edbi-minor-mode emacsql emacsql-psql format-sql copy-as-format anything-tramp helm-tramp ssh ssh-agency ssh-config-mode ssh-deploy ssh-tunnels company-eshell-autosuggest company-ghci company-shell company-restclient auctex auctex-latexmk auctex-lua slack flyspell-correct-helm wcheck-mode docker docker-compose-mode docker-tramp dockerfile-mode company-distel company-erlang distel-completion-lib edts erlang flycheck-rebar3 ivy-erlang-complete lfe-mode markdown-mode markdown-mode+ markdown-preview-mode markdown-toc synosaurus company-lua lua-mode luarocks websocket enotify jabber browse-at-remote python json-mode tern js2-refactor js2-mode py-autopep8 flycheck py-isort better-defaults company-quickhelp company-jedi epc undo-tree helm-swoop helm-projectile)))
 '(python-shell-interpreter "/home/michalz/tmp/py37/bin/python")
 '(whitespace-line-column 120))

(setq stack-trace-on-error t) ;;don’t popup Backtrace window


(savehist-mode t)

(require 'my_javascript)
(require 'my_python)
(require 'my_ansible)
(require 'my_grep)
(require 'my_dired_tree)
(require 'my_auctex)

(require 'flycheck-swagger-tools)
(require 'openapi-yaml-mode)

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
(put 'upcase-region 'disabled nil)

;;(set-default-font "lucidasanstypewriter-10")

(setq frame-title-format
   (list (format "%s %%S: %%j " (system-name))
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")))) 

(setq neo-smart-open t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(windmove-default-keybindings)
(load "server")
(unless (server-running-p) (server-start))

(winner-mode)

(set-default-font "DejaVu Sans Mono:style=Book:pixelsize=12")
;; (set-default-font "terminus:pixelsize=12")

(require 'mpdel)
(mpdel-mode)
