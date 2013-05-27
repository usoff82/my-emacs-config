;; PL/SQL mode
;(require 'plsql)
(autoload 'plsql-mode "plsql" "Pl/Sql mode" t)
(setq auto-mode-alist
      (append
       '(("\\.\\(p\\(?:k[bg]\\|ls\\)\\|sql\\)\\'" . plsql-mode))
       auto-mode-alist))
(eval-after-load "plsql-mode"
  '(progn
     ;; Настройка режима
     ;; Исключение символов # _ & из границ слова 
     (modify-syntax-entry ?# "w" sql-mode-syntax-table)
     (modify-syntax-entry ?_ "w" sql-mode-syntax-table)
     (modify-syntax-entry ?$ "w" sql-mode-syntax-table)

     ;; Выбор подсветки по умолчанию
     (sql-highlight-oracle-keywords)
     
     ; Настройка шаблонов соединений
     (setq sql-connection-alist
           '((pool-xgb_usoff82_1
              (sql-name "xgb_usoff82_1")
              (sql-product 'postgres)
              (sql-server "postgres49.1gb.ru")
              (sql-user "xgb_usoff82_1")
              (sql-password "f579ed73")
              (sql-database "xgb_usoff82_1")
              (sql-port 5432))
             (pool-host2_db1
              (sql-name "host2_db1")
              (sql-product 'postgres)
              (sql-server "host2.example.com")
              (sql-user "db2user")
              (sql-password "")
              (sql-database "db2")
              (sql-port 5432))
             (pool-local_mydb
              (sql-name "local_mydb")
              (sql-product 'postgres)
              (sql-server "localhost")
              (sql-user "myuser")
              (sql-password "")
              (sql-database "mydb")
              (sql-port 5432))))
     
     (defun sql-pool-xgb_usoff82_1 ()
       (interactive)
       (sql-connect-preset 'pool-xgb_usoff82_1))
     (defun sql-pool-host2_db1 ()
       (interactive)
       (sql-connect-preset 'host2_db1))
     (defun sql-pool-local_mydb ()
       (interactive)
       (sql-connect-preset 'pool-local_mydb))

     ;; this makes all it all happen via M-x sql-pool-host1_db1, etc.
     (defun sql-connect-preset (name)
       "Connect to a predefined SQL connection listed in `sql-connection-alist'"
       (eval `(let ,(cdr (assoc name sql-connection-alist))
                (flet ((sql-get-login (&rest what)))
                  (sql-product-interactive sql-product)))))

     ;; names the buffer *SQL: <host>_<db>, which is easier to 
     ;; find when you M-x list-buffers, or C-x C-b
     (defun sql-make-smart-buffer-name ()
       "Return a string that can be used to rename a SQLi buffer.
        This is used to set `sql-alternate-buffer-name' within
        `sql-interactive-mode'."
       (or (and (boundp 'sql-name) sql-name)
           (concat (if (not(string= "" sql-server))
                       (concat
                        (or (and (string-match "[0-9.]+" sql-server) sql-server)
                            (car (split-string sql-server "\\.")))
                        "/"))
                   sql-database)))
     
     (add-hook 'sql-interactive-mode-hook
               (lambda ()
                 (setq sql-alternate-buffer-name (sql-make-smart-buffer-name))
                 (sql-rename-buffer))) 
     ))
(provide 'emacs-rc-plsql)
