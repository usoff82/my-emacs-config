;(setq py-install-directory "~/.emacs.d/python-mode/")
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(elpy-enable)
;; Fix elpy "fixes" :)
(define-key ac-completing-map (kbd "RET") 'ac-complete)
(define-key ac-completing-map (kbd "<return>") 'ac-complete)

;;; Initialize Pymacs                                                                                           
;(autoload 'pymacs "pymacs" "Python Emacs Mode." t)
;(autoload 'pymacs-apply "pymacs")
;(autoload 'pymacs-call "pymacs")
;(autoload 'pymacs-eval "pymacs" nil t)
;(autoload 'pymacs-exec "pymacs" nil t)
;(autoload 'pymacs-load "pymacs" nil t)

(eval-after-load "python"
  '(progn
;     (require 'python)
     ;; Исключение символов из границ слова
     (dolist (char '(?_))
       (progn
         (modify-syntax-entry char "w" python-mode-syntax-table)
         (modify-syntax-entry char "w" inferior-python-mode-syntax-table)))
     ;; Initialize Rope
;     (pymacs-load "ropemacs" "rope-")
;     (setq ropemacs-enable-autoimport t)
     
     ;; Настройка IPython
      (elpy-use-ipython)
      (setq
       python-shell-interpreter "C:\\Python27\\python.exe"
       python-shell-interpreter-args
        "-i C:\\Python27\\Scripts\\ipython-script.py")
;     (setq
;      python-shell-interpreter "C:\\Python27\\python.exe"
;      python-shell-interpreter-args "-i C:\\Python27\\Scripts\\ipython-script.py console"
;      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;      python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
;      python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
;      python-shell-completion-string-code  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")


     ;; Показывать редактируемую функцию
     (which-function-mode t)

;     ;; Проверка синтаксиса с помощю flymake
;     (when (load "flymake" t)
;       (defun flymake-pyflakes-init ()
;         (let* ((temp-file (flymake-init-create-temp-buffer-copy
;                            'flymake-create-temp-inplace))
;                (local-file (file-relative-name
;                             temp-file
;                             (file-name-directory buffer-file-name))))
;           (list "pyflakes" (list local-file))))
;       (add-to-list 'flymake-allowed-file-name-masks
;                    '("\\.py\\'" flymake-pyflakes-init)))
;     (add-hook 'find-file-hook 'flymake-find-file-hook)
;
     ;; Исправляет баг с импортом файлов из текущего каталога
     (defun python-reinstate-current-directory ()
       "When running Python, add the current directory ('') to the head of sys.path.
For reasons unexplained, run-python passes arguments to the
interpreter that explicitly remove '' from sys.path. This means
that, for example, using `python-send-buffer' in a buffer
visiting a module's code will fail to find other modules in the
same directory.

Adding this function to `inferior-python-mode-hook' reinstates
the current directory in Python's search path."
       (python-send-string "sys.path[0:0] = ['']"))
     (add-hook 'inferior-python-mode-hook 'python-reinstate-current-directory)

     (defun my-semantic-hook ()
       (imenu-add-to-menubar "TAGS"))
     (add-hook 'python-mode-hook 'my-semantic-hook)

     (defun my-pdb-execfile()
       "Execute current file"
       (interactive)
       (python-shell-send-string
        (format "execfile('%s')\n" (buffer-file-name))))

     ; Настройки отладчика pbd
     (defun my-pdb-add-breakpoint ()
       "Insert breakpoint expression"
       (interactive)
       (if (string-match "^[ ]*import pdb; pdb.set_trace()" (thing-at-point 'line))
           (progn
             (kill-whole-line)
             (forward-line -1))
         (progn
           (move-end-of-line nil)
           (newline-and-indent)
           (insert "import pdb; pdb.set_trace()")
           (highlight-lines-matching-regexp "^[ ]*import pdb; pdb.set_trace()"))))

     (defun my-pdb-pprint()
       "Message the value of the variable the point is in"
       (interactive)
       (python-shell-send-string
        (format "pp %s\n" (thing-at-point 'word))))

     (defun my-pdb-jump()
       "Message the value of the variable the point is in"
       (interactive)
       (python-shell-send-string
        (format "jump %s\n" (line-number-at-pos))))

     ; Клавиатурные макросы для отладчика Pdb
     (defun my-pdb-next()
       "Step"
       (interactive)
       (goto-char (point-max))
       (insert "n")
       (comint-send-input))

     (defun my-pdb-step()
       "Step in"
       (interactive)
       (goto-char (point-max))
       (insert "step")
       (comint-send-input))

     (defun my-pdb-continue()
       "Continue execution"
       (interactive)
       (goto-char (point-max))
       (insert "continue")
       (comint-send-input))

     (defun my-pdb-restart()
       "Restart"
       (interactive)
       (goto-char (point-max))
       (insert "restart")
       (comint-send-input))


     (defun my-python-key-hook ()
       (local-set-key (kbd "<f8>") 'my-pdb-add-breakpoint)
       (local-set-key (kbd "<f3>") 'my-pdb-pprint)
       (local-set-key (kbd "C-j") 'my-pdb-jump)
       (local-set-key (kbd "<f9>") 'python-shell-send-buffer)
       (local-set-key (kbd "C-<f9>") 'python-shell-switch-to-shell)
       (local-set-key (kbd "C-/") 'rope-show-doc)
       (local-set-key (kbd "C-<f1>") 'python-describe-symbol)
       (local-set-key (kbd "<RET>") 'newline-and-indent)) ;; Автомантическое выставление отступов в новой строке
     (add-hook 'python-mode-hook 'my-python-key-hook)

     (defun my-pdb-key-hook ()
       (local-set-key (kbd "<f3>") 'my-pdb-pprint)
       (local-set-key (kbd "<f5>") 'my-pdb-continue)
       (local-set-key (kbd "<f6>") 'my-pdb-next)
       (local-set-key (kbd "<f7>") 'my-pdb-step)
       (local-set-key (kbd "<f9>") 'my-pdb-restart))
     (add-hook 'inferior-python-mode-hook 'my-pdb-key-hook)

     ;;======= Code folding =======
     (defun py-outline-level ()
       (let (buffer-invisibility-spec)
         (save-excursion
           (skip-chars-forward "    ")
           (current-column))))

     (defun my-python-outline-hook ()
       (setq outline-regexp "[^ \t]\\|[ \t]*\\(def\\|class\\|if\\|elif\\|else\\|while\\|try\\|exept\\|finaly\\) ")
       (setq outline-level 'py-outline-level)
       (setq outline-minor-mode-prefix "\C-t")
       (outline-minor-mode t)
       (show-paren-mode 1)
       (local-set-key (kbd "<C-kp-subtract>") 'hide-subtree)
       (local-set-key (kbd "<C-kp-add>") 'show-subtree))
     (add-hook 'python-mode-hook 'my-python-outline-hook)

;     (add-hook 'python-mode-hook
;          (lambda () (auto-complete-mode 1)))

     ;; Django
;     (require 'virtualenv)
;     (require 'pony-mode)
))

(provide 'emacs-rc-python-elpy)
