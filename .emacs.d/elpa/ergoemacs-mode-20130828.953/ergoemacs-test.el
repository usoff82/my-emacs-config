;;; ergoemacs-test.el --- tests for ErgoEmacs issues

;; Copyright (C) 2013 Matthew L. Fidler

;; Maintainer: Matthew L. Fidler
;; Keywords: convenience

;; ErgoEmacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.

;; ErgoEmacs is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with ErgoEmacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;; Todo:

;; 

;;; Code:

(setq ergoemacs-dir (file-name-directory (or load-file-name (buffer-file-name))))

(require 'ert)
(defvar ergoemacs-test-lorem-ipsum
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
enim ad minim veniam, quis nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
reprehenderit in voluptate velit esse cillum dolore eu fugiat
nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.")


;;;###autoload
(defun ergoemacs-test ()
  "Test ergoemacs issues."
  (interactive)
  (let ((ret t)
        (test))
    (when nil
      (message "Updating for the current version of emacs")
      (ergoemacs-warn-globally-changed-keys t))
    (ert "^ergoemacs-test-")))

(ert-deftest ergoemacs-test-google-code-145 ()
  "Backspace doesn't work in `isearch-mode'."
  (let ((old-ergoemacs-theme ergoemacs-theme)
        (old-ergoemacs-keyboard-layout ergoemacs-keyboard-layout)
        (macro (edmacro-parse-keys "C-f ars C-f <backspace> M-n" t))
        (ret t))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme nil)
    (setq ergoemacs-keyboard-layout "colemak")
    (ergoemacs-mode 1)
    (cua-mode 1)
    (let ((ergoemacs-debug t))
      (save-excursion
        (switch-to-buffer (get-buffer-create "*ergoemacs-test*"))
        (insert "aars1\nars2\nars3\nars4")
        (goto-char (point-min))
        (execute-kbd-macro macro)
        (when (looking-at ".*")
          (unless (string= "s1" (match-string 0))
            (setq ret nil)))
        (kill-buffer (current-buffer))))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme old-ergoemacs-theme)
    (setq ergoemacs-keyboard-layout old-ergoemacs-keyboard-layout)
    (ergoemacs-mode 1)
    (should (equal ret t))))

(ert-deftest ergoemacs-test-google-code-119 ()
  "C-f doesn't work in isearch-mode."
  (let ((old-ergoemacs-theme ergoemacs-theme)
        (old-ergoemacs-keyboard-layout ergoemacs-keyboard-layout)
        (macro (edmacro-parse-keys "C-f ars C-f C-f" t))
        (ret t))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme nil)
    (setq ergoemacs-keyboard-layout "colemak")
    (ergoemacs-mode 1)
    (cua-mode 1)
    (let ((ergoemacs-debug t))
      (save-excursion
        (switch-to-buffer (get-buffer-create "*ergoemacs-test*"))
        (insert "aars1\nars2\nars3\nars4")
        (goto-char (point-min))
        (execute-kbd-macro macro)
        (when (looking-at ".*")
          (unless (string= "3" (match-string 0))
            (setq ret nil)))
        (kill-buffer (current-buffer))))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme old-ergoemacs-theme)
    (setq ergoemacs-keyboard-layout old-ergoemacs-keyboard-layout)
    (ergoemacs-mode 1)
    (should (equal ret t))))

(ert-deftest ergoemacs-test-shifted-move-no-mark ()
  "Tests another shifted selection bug."
  (let ((old-ergoemacs-theme ergoemacs-theme)
        (old-ergoemacs-keyboard-layout ergoemacs-keyboard-layout)
        (macro (edmacro-parse-keys "M-H" t))
        (ret t))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme nil)
    (setq ergoemacs-keyboard-layout "colemak")
    (ergoemacs-mode 1)
    (cua-mode 1)
    (let ((ergoemacs-debug t))
      (save-excursion
        (switch-to-buffer (get-buffer-create "*ergoemacs-test*"))
        (delete-region (point-min) (point-max))
        (goto-char (point-min))
        (insert ";;")
        (execute-kbd-macro macro)
        (setq ret (not mark-active)) ;;  Shouldn't be selected
        (kill-buffer (current-buffer))))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme old-ergoemacs-theme)
    (setq ergoemacs-keyboard-layout old-ergoemacs-keyboard-layout)
    (ergoemacs-mode 1)
    (should (equal ret t))))

(ert-deftest ergoemacs-test-shifted-move-keep-mark ()
  "Test the shifted selection bug."
  (let ((old-ergoemacs-theme ergoemacs-theme)
        (old-ergoemacs-keyboard-layout ergoemacs-keyboard-layout)
        (macro (edmacro-parse-keys "C-SPC M-h M-S-i" t))
        (ret))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme nil)
    (setq ergoemacs-keyboard-layout "colemak")
    (ergoemacs-mode 1)
    (cua-mode 1)
    (let ((ergoemacs-debug t))
      (save-excursion
        (switch-to-buffer (get-buffer-create "*ergoemacs-test-shifted-move*"))
        (delete-region (point-min) (point-max))
        (insert ";;;;")
        (goto-char (point-min))
        (execute-kbd-macro macro)
        (setq ret mark-active) ;; Should be selected.
        (kill-buffer (current-buffer))))
    (ergoemacs-mode -1)
    (setq ergoemacs-theme old-ergoemacs-theme)
    (setq ergoemacs-keyboard-layout old-ergoemacs-keyboard-layout)
    (ergoemacs-mode 1)
    (should (equal ret t))))



(defun ergoemacs-test-global-key-set-before (&optional after key ergoemacs ignore-prev-global delete-def)
  "Test the global key set before ergoemacs-mode is loaded."
  (let* ((emacs-exe (ergoemacs-emacs-exe))
        (ret nil)
        (sk nil)
        (test-key (or key "M-k"))
        (w-file (expand-file-name "global-test" ergoemacs-dir))
        (temp-file (make-temp-file "ergoemacs-test" nil ".el")))
    (setq sk (format "(%s (lambda() (interactive) (with-temp-file \"%s\" (insert \"Ok\"))))"
                     (if ergoemacs
                         (format "ergoemacs-key \"%s\" " test-key)
                       (format "global-set-key (kbd \"%s\") " test-key))
                     w-file))
    (with-temp-file temp-file
      (insert "(condition-case err (progn")
      (unless after
        (when delete-def
          (insert (format "(global-set-key (kbd \"%s\") nil)" delete-def)))
        (insert sk))
      (insert (format "(add-to-list 'load-path \"%s\")" ergoemacs-dir))
      (insert "(setq ergoemacs-theme nil)")
      (insert "(setq ergoemacs-keyboard-layout \"us\")")
      (unless ignore-prev-global
          (insert "(setq ergoemacs-ignore-prev-global nil)"))
      (insert "(require 'ergoemacs-mode)(ergoemacs-mode 1)")
      (insert (format
               "(setq ergoemacs-test-macro (edmacro-parse-keys \"%s\" t))"
               test-key))
      (when after
        (when delete-def
          (insert (format "(global-set-key (kbd \"%s\") nil)" delete-def)))
        (insert sk))
      (insert "(execute-kbd-macro ergoemacs-test-macro)")
      (insert ") (error nil))")
      (insert "(kill-emacs)"))
    (message "%s"
             (shell-command-to-string
              (format "%s -Q -l %s" emacs-exe temp-file)))
    (delete-file temp-file)
    (when (file-exists-p w-file)
      (setq ret 't)
      (delete-file w-file))
    (symbol-value 'ret)))

(ert-deftest ergoemacs-test-global-key-set-before-1 ()
  "Test global set key before ergoemacs-mode loads."
  (should (equal (ergoemacs-test-global-key-set-before) t)))

(ert-deftest ergoemacs-test-global-key-set-after ()
  "Test global set key after ergoemacs loads."
  (should (equal (ergoemacs-test-global-key-set-before 'after) t)))

(ert-deftest ergoemacs-test-global-key-set-apps-m-c-before ()
  "Test setting <apps> m c before loading."
  :expected-result :failed
  (should (equal (ergoemacs-test-global-key-set-before nil
                                                       (if (eq system-type 'windows-nt)
                                                           "<apps> m c"
                                                         "<menu> m c") nil nil "<menu>") t)))

(ert-deftest ergoemacs-test-global-key-set-apps-m-before ()
  "Test setting <apps> m before loading."
  :expected-result :failed
  (should (equal (ergoemacs-test-global-key-set-before nil
                                                       (if (eq system-type 'windows-nt)
                                                           "<apps> m"
                                                         "<menu> m") nil nil "<menu>") t)))

(ert-deftest ergoemacs-test-global-key-set-apps-m-after ()
  "Test setting <apps> m after loading."
  (should (equal (ergoemacs-test-global-key-set-before 'after
                                                       (if (eq system-type 'windows-nt)
                                                           "<apps> m"
                                                         "<menu> m") nil nil "<menu>") t)))

(ert-deftest ergoemacs-test-global-key-set-apps-m-c-after ()
  "Test setting <apps> m c after loading."
  (should (equal (ergoemacs-test-global-key-set-before 'after
                                                       (if (eq system-type 'windows-nt)
                                                           "<apps> m c"
                                                         "<menu> m c") nil nil "<menu>") t)))

(ert-deftest ergoemast-test-global-key-set-after-c-e ()
  "Test C-e after"
  (should (equal (ergoemacs-test-global-key-set-before
                  'after "C-e" 'ergoemacs-key))))

(ert-deftest ergoemacs-test-ctl-c-ctl-c ()
  "Issue #64.  Should translate C-c C-c correctly."
  (let (ergoemacs-use-unicode-char)
    (should (string= (ergoemacs-pretty-key-rep "C-c C-c") "[Ctrl+c] [Ctrl+c]"))))

(ert-deftest ergoemacs-test-helm-M-x ()
  "Issue #65.  helm-M-x should not be helm-[Alt+x]."
  (let (ergoemacs-use-unicode-char)
    (should (string= (ergoemacs-pretty-key-rep "helm-M-x test") "helm-M-x test"))))

(ert-deftest ergoemacs-test-remove-ergoemacs-keys-in-org-mode ()
  "Should test Issue #67.
Ergoemacs in `org-mode' should be removed when turning off `ergoemacs-mode'"
  (let ((old (symbol-value 'ergoemacs-mode))
        ret)
    (unless old
      (ergoemacs-mode 1))
    (with-temp-buffer
      (org-mode)
      (ergoemacs-mode -1)
      (setq ret (not ergoemacs-org-mode-hook-mode)))
    (when old
      (ergoemacs-mode 1))
    (should ret)))

(ert-deftest ergoemacs-test-add-back-ergoemacs-keys-in-org-mode ()
    "Should be the second test for Issue #67.
When ergoemacs-mode is enabled, and an org-mode buffer is already
present, it should be re-enabled in that particular buffer."
  (let ((old (symbol-value 'ergoemacs-mode)))
    (when old
      (ergoemacs-mode -1))
    (set-buffer (get-buffer-create "*ergoemacs-test-org-mode*"))
    (org-mode)
    (ergoemacs-mode 1)
    (setq ret ergoemacs-org-mode-hook-mode)
    (kill-buffer (get-buffer-create "*ergoemacs-test-org-mode*"))
    (unless old
      (ergoemacs-mode -1))
    (should ret)))

(ert-deftest ergoemacs-test-cut-line-or-region ()
  "Issue #68.
kill-ring function name is used and such doesn't exist. It errs when
not using cua or cutting line. I think kill-region is what is meant."
  (let ((old-c cua-mode)
        (ret t))
    (cua-mode -1)
    (with-temp-buffer
      (insert ergoemacs-test-lorem-ipsum)
      (condition-case err
          (ergoemacs-cut-line-or-region)
        (error (setq ret nil))))
    (when old-c
      (cua-mode 1))
    (should ret)))

(provide 'ergoemacs-test)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ergoemacs-test.el ends here
;; Local Variables:
;; coding: utf-8-emacs
;; End:
