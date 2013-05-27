;; Насторойка аннотации кода
(load-file "~/.emacs.d/ipa.el")

;; Отображение коментариев над текущей строкой
(defun ipa-set-overlay-text (overlay text)
  (if (string-match ipa-annotation-id-regexp text)
      (setq text (match-string 2 text)))
  (save-excursion
    ;(beginning-of-line)
    (overlay-put overlay 'before-string
                 (if (equal text "")
                     ""
                   (propertize (concat "[" text "]\n") 'face ipa-annotation-face)))))
(defun ipa-create-overlay (pos text)
  (save-excursion
    (goto-char pos)
    (setq pos (point-at-bol))
    (let ((overlay (make-overlay pos pos nil t nil)))
     (ipa-set-overlay-text overlay text)
     (push (cons overlay text) ipa-annotations-in-buffer)
     (ipa-sort-overlays))))
(defun ipa-edit-after ()
  (interactive)  
  (ipa-edit t))

;; Насторойка меню и горячих клавиш
(require 'easymenu)
(define-key-after global-map [menu-bar mymenu] 
  (cons "Annotations" (make-sparse-keymap "Annotations"))
  'tools)
(easy-menu-add-item nil '("Annotations") ["New" ipa-insert])
(global-set-key (kbd "C-x a i") 'ipa-insert)
(easy-menu-add-item nil '("Annotations") ["Edit" ipa-edit-after])
(global-set-key (kbd "C-x a e") 'ipa-edit-after)
(easy-menu-add-item nil '("Annotations") ["Next" ipa-next])
(easy-menu-add-item nil '("Annotations") ["Previous" ipa-previous])
(easy-menu-add-item nil '("Annotations") "--")
(easy-menu-add-item nil '("Annotations") ["Hide/Show" ipa-toggle])
(global-set-key (kbd "C-x a a") 'ipa-toggle)

(provide 'emacs-rc-annotation)
