;; ��������� ������� ������

;; ��������� paredit
(global-set-key (kbd "C-c C-p") 'paredit-mode)

;; ����������� ����� ������ Alt+�������
(windmove-default-keybindings 'meta)

;; ������������ ������� 
(global-set-key [(control tab)] 'next-buffer)
(global-set-key [(control shift tab)] 'previous-buffer)

;; �������� ���
(global-set-key [(control a)] 'mark-whole-buffer)

;; ������� ������� ������
(global-set-key (kbd "<M-f4>") 'kill-this-buffer)

;; ��������� ������� ������
(global-set-key (kbd "<f2>") 'save-buffer)
(global-set-key (kbd "C-s") 'save-buffer)

;; ������� ����
;(global-set-key (kbd "<C-o>") 'menu-find-file-existing)

;; ���������
;(global-set-key [f3] 'isearch)

;; ���������  ������ ����� re-builder
(global-set-key (kbd "C-f") 're-builder)
(defun reb-keys-hook()
  (local-set-key (kbd "<f3>") 'reb-next-match)
  (local-set-key (kbd "C-<f3>") 'reb-prev-match))
(dolist (mode '(reb-mode-hook))
  (add-hook mode 'reb-keys-hook))

;; Undo/Redo
;;(require 'redo+)
;;(global-set-key (kbd "C-S-z") 'redo)
;;(global-set-key (kbd "C-z") 'undo)

(provide 'emacs-rc-kbd)
