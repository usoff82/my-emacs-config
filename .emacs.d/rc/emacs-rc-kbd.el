;; Настройка горячих клавиш

;; Включение paredit
(global-set-key (kbd "C-c C-p") 'paredit-mode)

;; Перемещение между окнами Alt+стрелки
(custom-set-variables
 '(ergoemacs-use-ergoemacs-metadown nil)
 '(ergoemacs-use-ergoemacs-metaleft nil)
 '(ergoemacs-use-ergoemacs-metaright nil)
 '(ergoemacs-use-ergoemacs-metaup nil))
(windmove-default-keybindings 'meta)

;; Переключение буферов 
;(global-set-key [(control tab)] 'next-buffer)
;(global-set-key [(control shift tab)] 'previous-buffer)

;; Scroll Lock
(global-set-key (kbd "<scroll>") 'scroll-lock-mode)

;; Закрыть текущий буффер
(global-set-key (kbd "<M-f4>") 'kill-this-buffer)

;; Сохранить текущий буффер
(global-set-key (kbd "<f2>") 'save-buffer)
(global-set-key (kbd "C-s") 'save-buffer)

;; Настройка  поиска через re-builder
(global-set-key (kbd "C-f") 're-builder)
(defun reb-keys-hook()
  (local-set-key (kbd "<f3>") 'reb-next-match)
  (local-set-key (kbd "C-<f3>") 'reb-prev-match))
(dolist (mode '(reb-mode-hook))
  (add-hook mode 'reb-keys-hook))

;; Undo/Redo
(require 'undo-tree)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "C-y") 'redo)

(provide 'emacs-rc-kbd)
