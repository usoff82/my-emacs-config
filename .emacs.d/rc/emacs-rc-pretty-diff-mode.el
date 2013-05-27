;; Pretty diff mode
(autoload 'ediff-buffers "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files-remote "ediff" "Intelligent Emacs interface to diff")
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(provide 'emacs-rc-pretty-diff-mode)