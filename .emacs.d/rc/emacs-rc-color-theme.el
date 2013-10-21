;; ��������� �������� �����
;(require 'color-theme-railscasts)
(color-theme-zenburn)

;; ��������� ���������� ��� pl+
(defvar hi-plplus-variables
  '(("\\(\\[.*?\\]\\|::\\|->\\|\\:\\s-*\\sw*\\)" .
     font-lock-variable-name-face)))
(mapcar (lambda (mode)
          (font-lock-add-keywords mode hi-plplus-variables))
        '(perl-mode c++-mode c-mode java-mode python-mode ruby-mode sql-mode plsql-mode))

;; ��������� ������� pl+
(defvar hi-plplus-function
  '(("\\.\\([a-zA-Z_0-9]*\\)\\s-*(" 1
     font-lock-builtin-face)))
(mapcar (lambda (mode)
          (font-lock-add-keywords mode hi-plplus-function))
        '(perl-mode c++-mode c-mode java-mode python-mode ruby-mode sql-mode plsql-mode ))

;; ��������� �������� pl+
(defvar hi-plplus-macro
  '(("&[a-zA-Z0-9_]*" .
     font-lock-preprocessor-face)))
(mapcar (lambda (mode)
          (font-lock-add-keywords mode hi-plplus-macro))
        '(perl-mode c++-mode c-mode java-mode python-mode ruby-mode sql-mode plsql-mode))

;; ��������� ������
(defvar hi-bounds
  '(("\\((\\|)\\)" .
     font-lock-keyword-face)))
(mapcar (lambda (mode)
          (font-lock-add-keywords mode hi-bounds))
        '(perl-mode c++-mode c-mode java-mode python-mode ruby-mode sql-mode plsql-mode octave-mode))

;; ��������� ����������
(defvar hi-operators
  '(("\\(-\\|+\\|*\\|/\\|||\\|:=\\|=\\|<\\|>\\|!\\)" .
     font-lock-builtin-face)))
(mapcar (lambda (mode)
          (font-lock-add-keywords mode hi-operators))
        '(perl-mode c++-mode c-mode java-mode python-mode ruby-mode sql-mode plsql-mode octave-mode))

;; ��������� ����
(defvar hi-numbers
  '(("\\b\\(0[xX][0-9a-fA-F]+[lL]?\\|[0-9]+\\.?[0-9]*\\([eE][-+]?[0-9]+\\)?\\([lL]\\|[fF]\\|[dD]\\)?\\)\\b" 1
     font-lock-constant-face)))
(mapcar (lambda (mode)
          (font-lock-add-keywords mode hi-numbers))
        '(perl-mode c++-mode c-mode java-mode python-mode ruby-mode sql-mode plsql-mode octave-mode))

;; ��������� �����
;(defvar hi-string
;  '(("[.?!][]\"')}]*\\($\\| $\\|\t\\|  \\)[ \t\n]*" 1
;     font-lock-string-face)))
;(mapcar (lambda (mode)
;          (font-lock-add-keywords mode hi-string))
;        '(perl-mode c++-mode c-mode java-mode python-mode ruby-mode sql-mode plsql-mode log4j-mode))


;; ����� �������
(setq-default cursor-type 'bar)

;; ��������� ������� ������
(global-hl-line-mode t)

;; ���� ���������� ������ � �������
(require 'skeleton)
(setq skeleton-pair t)
(show-paren-mode t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;(global-set-key (kbd "'") 'skeleton-pair-insert-maybe))

(provide 'emacs-rc-color-theme)
