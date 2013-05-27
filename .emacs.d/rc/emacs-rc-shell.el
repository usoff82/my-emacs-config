;; Настройка коммандной строки M-x shell
(defadvice shell (after my-shell-advice)
(set-buffer-process-coding-system 'cp1251 'cp1251))
(ad-activate 'shell)

(provide 'emacs-rc-shell)

