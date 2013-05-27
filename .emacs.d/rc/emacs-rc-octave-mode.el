(autoload 'octave-mode "octave-mod" nil t)

(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

(require 'ac-octave)

(defun ac-octave-mode-setup ()
  (setq ac-sources '(ac-source-octave)))

;(add-hook 'inferior-octave-mode-hook
;          (lambda ()
;            (turn-on-font-lock)
;            (define-key inferior-octave-mode-map [up]
;              'comint-previous-input)
;            (define-key inferior-octave-mode-map [down]
;              'comint-next-input)))


(defun octave-send-buffer ()
  "Send current region to the inferior Octave process."
  (interactive)
  (inferior-octave t)
  (let ((proc inferior-octave-process)
	(line (concat "cd " (file-name-directory buffer-file-name) "; " "source('" buffer-file-name "')\n")))
    (with-current-buffer inferior-octave-buffer
      (setq inferior-octave-output-list nil)
      (setq inferior-octave-receive-in-progress t)
	(inferior-octave-send-list-and-digest (list (concat line "\n")))
	(while inferior-octave-receive-in-progress
	  (accept-process-output proc))
	(insert-before-markers
	 (mapconcat 'identity
		    (append
		     (mapcar 'inferior-octave-strip-ctrl-g
			     inferior-octave-output-list)
                     (list "octave.exe> "))
		    "\n"))))
  (if octave-send-show-buffer
      (display-buffer inferior-octave-buffer)))

(defun my-octave-hook ()
  (ac-octave-mode-setup)
  (auto-complete-mode 1)
  (imenu-add-to-menubar "TAGS")
  (local-set-key (kbd "<f9>") 'octave-send-buffer))
(add-hook 'octave-mode-hook 'my-octave-hook)

(provide 'emacs-rc-octave-mode)
