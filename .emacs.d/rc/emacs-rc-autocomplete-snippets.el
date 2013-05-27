;; Авто растановка скобок и кавычек
(require 'skeleton)
(setq skeleton-pair t)
(show-paren-mode t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;(global-set-key (kbd "'") 'skeleton-pair-insert-maybe))

;; Настройка auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
;(global-auto-complete-mode t)
(setq ac-dwim t)

; Список вариантов Shift+Tab
;(define-key ac-mode-map (kbd "<backtab>") 'ac-fuzzy-complete)
;(define-key ac-mode-map (kbd "M-TAB") 'ac-fuzzy-complete)

; Автодополнение функций для Elisp
(defun ac-sources-lisp-mode-hook ()
  (setq ac-sources '(ac-source-features ac-source-symbols ac-source-functions ac-source-variables ac-source-words-in-buffer))
  (auto-complete-mode t))
(dolist (mode '(lisp-interaction-mode-hook emacs-lisp-mode-hook))
  (add-hook mode 'ac-sources-lisp-mode-hook))

;;
;(defvar ac-source-to-mailaddr
;  '((candidates . (list "foo1@example.com"
;                        "foo2@example.com"
;                        "foo3@example.com"))
;    (prefix . "^To: \\(.*\\)")
;    (symbol . "v")))
;;(setq ac-sources '(ac-source-to-mailaddr)) ; установка словаря
;(add-to-list 'ac-sources 'ac-source-to-mailaddr) ;добавление словаря

		  
		  
;; Настройка системы шаблонов YASnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
; Выбор шаблона
(global-set-key (kbd "<escape> s s") 'yas/insert-snippet)
; в текстовом виде
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))


;;Another code for solving conflicts in Company and Yasnippet.
;  (defun check-expansion ()
;    (save-excursion
;      (if (looking-at "\\_>") t
;        (backward-char 1)
;        (if (looking-at "\\.") t
;          (backward-char 1)
;          (if (looking-at "->") t nil)))))

;  (defun do-yas-expand ()  
;    (let ((yas/fallback-behavior 'return-nil))
;      (yas/expand)))
;
;  (defun tab-indent-or-complete ()
;    (interactive)
;    (if (minibufferp)
;        (minibuffer-complete)
;      (if (or (not yas/minor-mode)
;              (null (do-yas-expand)))
;          (if (check-expansion)
;              (company-complete-common)
;            (indent-for-tab-command)))))
;
;  (global-set-key [tab] 'tab-indent-or-complete)
							 
							 

;; Company Mode http://www.emacswiki.org/cgi-bin/emacs-en/CompanyMode
;(company-mode)
;(defun company-my-php-backend (command &optional arg &rest ignored)
;    (case command
;      ('prefix (and (eq major-mode 'php-mode)
;                    (company-grab-symbol)))
;      ('sorted t)
;      ('candidates (all-completions
;                    arg 
;                    (if (and (boundp 'my-php-symbol-hash)
;                             my-php-symbol-hash)
;                        my-php-symbol-hash
;
;                      (message "Fetching completion list...")
;
;                      (with-current-buffer
;                          (url-retrieve-synchronously "http://php.net/quickref.php")
;
;                        (goto-char (point-min))
;
;                        (if (re-search-forward "<!-- result list start -->" nil t)
;                            (let ((end (save-excursion
;                                         (if (re-search-forward "<!-- result list end -->" nil t)
;                                             (point)))))
;                              (if end
;                                  (let ((hash (make-hash-table)))
;                                    (while (re-search-forward ">\\([^<]+\\)</a>" end t)
;                                      (puthash (match-string 1) t hash))
;                                    (setq my-php-symbol-hash hash)))))))))))
;(add-to-list 'company-backends 'company-my-php-backend)

(provide 'emacs-rc-autocomplete-snippets)
