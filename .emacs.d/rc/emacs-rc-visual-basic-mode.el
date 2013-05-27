; Visual Basic mode 
;(load-file "~/.emacs.d/visual-basic-mode.el")
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|vb\\|vbs\\|cls\\)$" .
                                 visual-basic-mode)) auto-mode-alist))

(eval-after-load "visual-basic-mode"
  '(progn
     ; Не показывать символы конца строки
     (defun remove-dos-eol ()
       "Do not show ^M in files containing mixed UNIX and DOS line endings."
       (interactive)
       (setq buffer-display-table (make-display-table))
       (aset buffer-display-table ?\^M []))

     (add-hook 'visual-basic-mode-hook 'remove-dos-eol)))

(provide 'emacs-rc-visual-basic-mode)
