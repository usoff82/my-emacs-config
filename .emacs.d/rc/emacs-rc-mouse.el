;; ��������� ����������

;; �� �������� ���������� �����
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ; ��� ���������
(setq mouse-wheel-follow-mouse 't) ; ������������ ���� ��� �����

;; ������� ��������� � ����������
(setq scroll-step 1)
(setq hscroll-step 1)
(setq scroll-conservatively 100000) ; �� ������� �� �������� �������� ��� ����������

;; �������� �������� �������� �� N ���� �� ����
(setq scroll-margin 2)

;; �� ���������� � clipboad ���������� ����� �������
(setq mouse-drag-copy-region nil)

(provide 'emacs-rc-mouse)