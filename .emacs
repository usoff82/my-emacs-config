;; loading benchmark
(require 'cl)
(defvar *emacs-load-start* (current-time))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ������� ������� ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
    (package-initialize))
;; use more repositories for elpa
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; ��������� � load-path ��� �������� �� ~/.emacs.d
(let ((base "~/.emacs.d"))
  (add-to-list 'load-path base)
  (dolist (f (directory-files base))
    (let ((name (concat base "/" f)))
      (when (and (file-directory-p name) 
                 (not (equal f ".."))
                 (not (equal f ".")))
        (add-to-list 'load-path name)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ���������� ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��������� ����
(require 'emacs-rc-mouse)

;; ��������� ������� ������
(require 'emacs-rc-kbd)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ������� ��� ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ����� ���������
(menu-bar-mode t)         ;; ���������� ����
(scroll-bar-mode 'right)  ;; �������� ������

;; ��������� �������� �����
(require 'emacs-rc-color-theme)

;; ��������� �������
(require 'emacs-rc-tabbar)

;; ���������� speedbar
(require 'sr-speedbar)

;; ��������� ���������, ������������ ��������� �� F5
(require 'emacs-rc-evm-coding-systems)

; ���������� ����
;(desktop-save-mode 1)

; ���������� ���������� �����
;(require 'saveplace)
;(setq-default save-place t)
;(savehist-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ����������� ������� ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��������� �������������� � ��������
;(require 'emacs-rc-autocomplete-snippets)

;; Pretty diff mode
(require 'emacs-rc-pretty-diff-mode)

;; ��������� ���������� Subversion 1.7
(require 'vc-svn17)

;; �������� ����
;(require 'emacs-rc-annotation)

;; Lisp mode
(require 'emacs-rc-lisp)

;; ��������� ���������� ������ M-x shell
(require 'emacs-rc-shell)

;; PL/SQL mode
(require 'emacs-rc-plsql)
 
;; Visual Basic mode 
(require 'emacs-rc-visual-basic-mode)

;; Octave Mode
(require 'emacs-rc-octave-mode)

;; Python mode
;(require 'emacs-rc-python-company)
;(require 'emacs-rc-python-mode-company)
(require 'emacs-rc-python-elpy)
 
;; CEDET
;(load-file "~/.emacs.d/rc/emacs-rc-cedet.el")
;(require 'emacs-rc-cedet)

;; ECB
;(load-file "~/.emacs.d/rc/emacs-rc-ecb.el")
;(require 'emacs-rc-ecb)


; Custom setings
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(fringe-mode nil nil (fringe))
 '(indicate-buffer-boundaries (quote left))
 '(pdb-path (quote C:/Python27/Lib/pdb\.py))
 '(tool-bar-mode nil)
 '(truncate-lines t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "outline" :family "Consolas")))))
(put 'ido-exit-minibuffer 'disabled nil)

;; Loading benchmark
;;(message "My .emacs loaded in %ds" (destructuring-bind (hi lo ms) (current-time)
;;                                     (- (+ hi lo) (+ (first *emacs-load-start*) (second *emacs-load-start*)))))
