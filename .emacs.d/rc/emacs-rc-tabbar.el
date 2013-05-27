;; Настройка таббара
(add-to-list 'load-path "~/.emacs.d/tabbar")
(require 'tabbar)
(tabbar-mode)
 
;(setq tabbar-buffer-groups-function
;    (lambda () (list "All")))


(global-set-key [M-S-left] 'tabbar-backward)
(global-set-key [M-S-right] 'tabbar-forward)
(global-set-key [M-S-up] 'tabbar-forward-group)
(global-set-key [M-S-down] 'tabbar-backward-group)

(global-set-key [(control f10)] 'tabbar-local-mode)
;(require 'aquamacs-tabbar)

(provide 'emacs-rc-tabbar)