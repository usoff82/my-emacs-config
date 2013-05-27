; Visual Basic mode 
(autoload 'log4j-mode "log4j-mode" "log4j mode." t)
(setq auto-mode-alist (append '(("\\.\\(log\\|log4j\\)$" .
                                 log4j-mode)) auto-mode-alist))

; Не показывать символы конца строки
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(add-hook 'visual-basic-mode-hook 'remove-dos-eol)

(provide 'emacs-rc-visual-basic-mode)
