;; Start benchmark
(defvar *emacs-load-start* (current-time))

(require 'cl)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Загрузк пакетов ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Добавляет в load-path все каталоги из ~/.emacs.d
(let ((base "~/.emacs.d"))
  (add-to-list 'load-path base)
  (dolist (f (directory-files base))
    (let ((name (concat base "/" f)))
      (when (and (file-directory-p name) 
                 (not (equal f ".."))
                 (not (equal f ".")))
        (add-to-list 'load-path name)))))

;; use more repositories for elpa
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(require 'package)
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Управление ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Настройка мыши
(require 'emacs-rc-mouse)

;; Эргоемакс, нужно закоментировать в ergoemacs-themes.el переопределение клавиш <M-up> <M-down> <M-left> <M-right>
(ergoemacs-mode 1)

;; Настройка горячих клавиш
;(require 'emacs-rc-kbd)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Внешний вид ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Общие настройки
(menu-bar-mode t)         ;; Показывать меню
(scroll-bar-mode 'right)  ;; Скролбар справа

;; Настройки цветовой схемы
(require 'emacs-rc-color-theme)

;; Настройка таббара
(require 'emacs-rc-tabbar)

;; Нормальный speedbar
(require 'sr-speedbar)

;; Покзывать номера строк
(global-linum-mode 1)

;; Автодополнеие в коммандной строке
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; Настройка кодировок, Переключение кодировок по F5
(require 'emacs-rc-evm-coding-systems)

;; Redo
;(require 'redo+)

;; сохранение окон
;(desktop-save-mode 1)

; Созранение последнего места
;(require 'saveplace)
;(setq-default save-place t)
;(savehist-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Программные режимыы ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Настройка автодополнения и шаблонов
;(require 'emacs-rc-autocomplete-snippets)

;; Pretty diff mode
(require 'emacs-rc-pretty-diff-mode)

;; Анотация кода
;(require 'emacs-rc-annotation)

;; Lisp mode
(require 'emacs-rc-lisp)

;; Настройка коммандной строки M-x shell
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
 '(ergoemacs-keyboard-layout "us")
 '(ergoemacs-mode-used "5.8.0")
 '(ergoemacs-theme nil)
 '(ergoemacs-use-menus t)
 '(fringe-mode nil nil (fringe))
 '(indicate-buffer-boundaries (quote left))
 '(pdb-path (quote C:/Python27/Lib/pdb\.py))
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(windmove-default-keybindings (quote meta)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "outline" :family "Consolas")))))
(put 'ido-exit-minibuffer 'disabled nil)

;; Stop benchmark
(message "My .emacs loaded in %ds" (float-time (time-subtract (current-time) *emacs-load-start*)))
