; ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))
(global-set-key [C-f9] 'ido-find-file-in-tag-files)

(provide 'emacs-rc-ido)