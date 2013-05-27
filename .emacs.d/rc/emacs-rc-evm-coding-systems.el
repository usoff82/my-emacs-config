;; Настройка кодировок
; Кодировка по умолчанию
(prefer-coding-system 'windows-1251)
; Переключение кодировок по F5
(setq evm-coding-systems-list (make-ring 10)) 
(ring-insert evm-coding-systems-list 'windows-1251)
(ring-insert evm-coding-systems-list 'iso-8859-5)
(ring-insert evm-coding-systems-list 'cp866-dos)
(ring-insert evm-coding-systems-list 'utf-8)
(ring-insert evm-coding-systems-list 'koi8-r) 
(ring-insert evm-coding-systems-list 'alternativnyj)

(global-set-key [f5] 
                (lambda () 
                  (interactive) 
                  (let* ((keys (recent-keys)) 
                         (len (length keys)) 
                         (key1 (if (> len 0) (elt keys (- len 1)) nil)) 
                         (key2 (if (> len 1) (elt keys (- len 2)) nil)) 
                         cs) 
                    (if (eq key1 key2) 
                        (setcar evm-coding-systems-list 
                                (ring-plus1 (car evm-coding-systems-list) 
                                            (ring-length evm-coding-systems-list))) 
                      (setcar evm-coding-systems-list 0)) 
                    (set-buffer-multibyte t) 
                    (recode-region (point-min) (point-max) (aref (cddr evm-coding-systems-list) 
                                                                 (car evm-coding-systems-list)) buffer-file-coding-system)) 
                  (set-buffer-file-coding-system (aref (cddr evm-coding-systems-list) (car evm-coding-systems-list)))))

(provide 'emacs-rc-evm-coding-systems)
