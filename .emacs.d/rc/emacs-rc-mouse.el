;; Настройка скроллинга

;; Не ускорять скороллинг мышью
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ; шаг прокрутки
(setq mouse-wheel-follow-mouse 't) ; прокручивать окно под мышью

;; Плавный скроллинг с клавиатуры
(setq scroll-step 1)
(setq hscroll-step 1)
(setq scroll-conservatively 100000) ; не прыгать на середину страницы при скроллинге

;; Начинать промотку страницы за N сток до края
(setq scroll-margin 2)

;; Не копировать в clipboad выделенный мышью участок
(setq mouse-drag-copy-region nil)

(provide 'emacs-rc-mouse)