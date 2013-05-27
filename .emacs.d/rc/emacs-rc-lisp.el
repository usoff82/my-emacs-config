;; настройка Лисп режимов

;; Исключение символов из границ слова
(dolist (char '(?- ??))
  (progn
    (modify-syntax-entry char "w" lisp-interaction-mode-syntax-table)
    (modify-syntax-entry char "w" emacs-lisp-mode-syntax-table)))

; Автодополнение функций для Elisp
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
;(global-auto-complete-mode t)
(setq ac-dwim t)

(defun ac-sources-lisp-mode-hook ()
  (setq ac-sources '(ac-source-features ac-source-symbols ac-source-functions ac-source-variables ac-source-words-in-buffer))
  (auto-complete-mode t))
(dolist (mode '(lisp-interaction-mode-hook emacs-lisp-mode-hook))
  (add-hook mode 'ac-sources-lisp-mode-hook))

(provide 'emacs-rc-lisp)
