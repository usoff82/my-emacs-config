(setq py-install-directory "~/.emacs.d/python-mode/")
;(require 'python-mode)
;(require 'python)
;(autoload 'python "python" "Python" t)
;;(autoload 'company "company" "Company Mode." t)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Исключение символов из границ слова
(eval-after-load "python"
  '(progn
     (dolist (char '(?_))
       (progn
         (modify-syntax-entry char "w" python-mode-syntax-table)
         (modify-syntax-entry char "w" inferior-python-mode-syntax-table)))))

;; Initialize Pymacs                                                                                           
;(require 'pymacs)
(autoload 'pymacs "pymacs" "Python Emacs Mode." t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;;(eval-after-load "python"
(eval-after-load "python-mode"
  '(progn
     (require 'python-mode)
	 (require 'gud)      
     ;;(require 'python)
     ;; Initialize Rope
     (pymacs-load "ropemacs" "rope-")
     (setq ropemacs-enable-autoimport t)

     ;; Проверка синтаксиса с помощю flymake
     (when (load "flymake" t)
       (defun flymake-pyflakes-init ()
         (let* ((temp-file (flymake-init-create-temp-buffer-copy
                            'flymake-create-temp-inplace))
                (local-file (file-relative-name
                             temp-file
                             (file-name-directory buffer-file-name))))
           (list "pyflakes" (list local-file))))
       (add-to-list 'flymake-allowed-file-name-masks
                    '("\\.py\\'" flymake-pyflakes-init)))
     (add-hook 'find-file-hook 'flymake-find-file-hook)
     
     ;; Исправляет баг с импортом файлов из текущего каталога
;     (python-remove-cwd-from-path nil)
;     (defun python-reinstate-current-directory ()
;       "When running Python, add the current directory ('') to the head of sys.path.
;For reasons unexplained, run-python passes arguments to the
;interpreter that explicitly remove '' from sys.path. This means
;that, for example, using `python-send-buffer' in a buffer
;visiting a module's code will fail to find other modules in the
;same directory.
; 
;Adding this function to `inferior-python-mode-hook' reinstates
;the current directory in Python's search path."
;       (python-send-string "sys.path[0:0] = ['']"))
;     (add-hook 'inferior-python-mode-hook 'python-reinstate-current-directory)

     ;(require 'company)
     (defun python-company-hook()
       (company-mode))
     (dolist (mode '(python-mode-hook))
       (add-hook mode 'python-company-hook))

;(py-shell)


(defun my-python-execfile()
 "Execute current file"
 (interactive)
 (save-excursion
   (comint-send-string
    (get-buffer-process "*Python*")
    (format "execfile('%s')\n" (buffer-file-name)))))

      (defun my-pdb-pprint()
      "Message the value of the variable the point is in"
      (interactive)
     (save-excursion
      (comint-send-string
       (get-buffer-process "*Python*")
       (format "pp %s\n" (thing-at-point 'word))))
      ;(other-window -1)
	  ) 	
	  
	  (defun my-pdb-next()
 "Message the value of the variable the point is in"
 (interactive)
 (goto-char (point-max))
 (insert "n")
 (comint-send-input))
	
     (defun my-python-key-hook ()
;       (local-set-key (kbd "<f9>") 'py-execute-buffer)
       (local-set-key (kbd "<f9>") 'my-python-execfile)
	   (local-set-key (kbd "<f3>") 'my-pdb-pprint)
	   (global-set-key (kbd "<f6>") 'my-pdb-next)
       (local-set-key (kbd "C-<f9>") 'py-shell)                                                                                                                                          
	   (local-set-key '[C-f10] 'gud-next)                                                                                                                  
       (local-set-key '[C-f11] 'gud-step)                                                                                                                  
       (local-set-key '[C-f5] 'gud-cont)                                                                                                                   
       (local-set-key '[C-f12] 'gud-break) 
       (local-set-key (kbd "<RET>") 'newline-and-indent)) ;; Автоматическое выставление отступов в новой строке
     (add-hook 'python-mode-hook 'my-python-key-hook)

     ;; Django
     (require 'virtualenv)
     (require 'pony-mode)
))

(provide 'emacs-rc-python-mode-company)
