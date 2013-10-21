; log4j mode 
(autoload 'log4j-mode "log4j-mode" "log4j mode." t)
(setq auto-mode-alist (append '(("\\.\\(log\\|log4j\\)$" .
                                 log4j-mode)) auto-mode-alist))

; Не показывать символы конца строки
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(add-hook 'log4j-mode-hook 'remove-dos-eol)

;; Насторойка меню и горячих клавиш
(require 'easymenu)

(defun my-log4j-hook ()
   ;(auto-revert-tail-mode t)
   ;(read-only-mode t)

  (define-key-after log4j-mode-map [menu-bar mymenu] 
    (cons "Log4j" (make-sparse-keymap "Log4j"))
    'tools)
  (easy-menu-add-item nil '("Log4j") ["Filter" log4j-start-filter])
  (easy-menu-add-item nil '("Log4j") ["Browse Source" log4j-browse-source])
  (easy-menu-add-item nil '("Log4j") "--")
  (easy-menu-add-item nil '("Log4j") ["Next" log4j-forward-record])
  (easy-menu-add-item nil '("Log4j") ["Previous" log4j-backward-record])
  (easy-menu-add-item nil '("Log4j") "--")
  (easy-menu-add-item nil '("Log4j") ["Tail Mode" auto-revert-tail-mode])
  (easy-menu-add-item nil '("Log4j") ["Read Only" read-only-mode])

  (define-key log4j-mode-local-map [(control down)] 'log4j-forward-record)
  (define-key log4j-mode-local-map [(control up)] 'log4j-backward-record))

(add-hook 'log4j-mode-hook 'my-log4j-hook)

(provide 'emacs-rc-log4j-mode)
