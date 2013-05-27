(require 'thingatpt)

; Определение границ текущего слова
(defun py-complete-python-dotexpr-begin nil
  (re-search-backward "[^a-zA-Z_0-9\\.]")
  (forward-char))

(defun py-complete-python-dotexpr-end nil
  (re-search-forward "[a-zA-Z_0-9\\.]*"))

(put 'python-dotexpr 'beginning-op 'py-complete-python-dotexpr-begin)
(put 'python-dotexpr 'end-op 'py-complete-python-dotexpr-end)

; функция на питоне
(pymacs-exec "def help_12(object_str):
    a = 12
    d = 14
    objects = dir()
    print objects
    return [o for o in objects]")

(defun help_12 (X)
  "thisandthat."
  (pymacs-call "help_12" X))

;(mapconcat 'identity (help_12 "spacing") "\n") ; конкатенация списка

; вывод в буфер
(defun py-complete-show (string)
  (display-message-or-buffer string "*PythonHelp*"))

(defun py-complete-help-thing-at-point nil
  (interactive)
  (require 'thingatpt)
  (let ((sym (help_12 (thing-at-point 'python-dotexpr))))
    (if sym
        (py-complete-show sym))))

; привязка клавиш
(global-set-key [f3] 'py-complete-help-thing-at-point)
