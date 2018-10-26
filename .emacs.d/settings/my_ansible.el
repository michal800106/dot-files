;; ANSIBLE CONFIGURATION
;; --------------------------------------

;Package specific initialization
(add-hook
 'after-init-hook
 '(lambda ()

    ;; Looks like you need Emacs 24 for projectile
    (unless (< emacs-major-version 24)
      (require 'projectile)
      (projectile-global-mode))

    (require 'company-ansible)

    (add-hook 'yaml-mode-hook '(lambda () (company-mode 1)))
    (add-to-list 'company-backends 'company-ansible)

    ))
(put 'downcase-region 'disabled nil)

(provide 'my_ansible)
