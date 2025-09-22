(require 'package)

(package-initialize)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))

(unless package-archive-contents
  (package-refresh-contents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(require 'use-package)

(use-package elfeed
  :ensure t)

;; Evil 本体
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t) ;; C-u で上にスクロール
  (setq evil-want-C-i-jump t) ;; C-i を jump forward にする（通常は tab に取られる
  (setq evil-undo-system 'undo-redo) ;; Emacs 28以降で追加された新しいundo機構
  (setq evil-want-integration t)     ;; 特定のEmacsパッケージと連携
  (setq evil-want-keybinding nil) ;; evil-collectionと併用する場合は必ずnil
  :config
  (evil-mode 1))

;; Evil-collection：他のEmacsパッケージもVim風操作に
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Vim風キーバインドを定義しやすくする（任意）
(use-package general
  :ensure t
  :config
  (general-evil-setup))

;; Vimのsurround操作（"ds", "cs", "ys" 等）
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; Vimのコメント操作（gccなど）
(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

;; Vimの交換（gxなど）やURLオープン（便利）
(use-package evil-exchange
  :ensure t
  :config
  (evil-exchange-install))

(use-package better-jumper
  :ensure t
  :init
  (better-jumper-mode +1))

;; evilのジャンプリストに better-jumper を統合
(use-package evil
  :config
  (define-key evil-motion-state-map (kbd "C-o") #'better-jumper-jump-backward)
  (define-key evil-motion-state-map (kbd "C-i") #'better-jumper-jump-forward))

;; よりVimっぽくしたい場合の追加（任意）
(use-package evil-numbers
  :ensure t) ;; C-a / C-xでインクリメント・デクリメント

(use-package evil-org
  :after org
  :ensure t
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))


(use-package paredit
  :ensure t
  :config
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode))

(use-package company
  :ensure t
  :config
  (global-company-mode))

(use-package ddskk
  :ensure t
  :config
  (setq default-input-method "japanese-skk"))
					;(setq skk-use-act t))

(use-package lsp-mode
  :ensure t)

(use-package lsp-java
  :ensure t)
(add-hook 'java-mode-hook #'lsp)

(use-package lsp-nix
  :ensure lsp-mode
  :after (lsp-mode)
  :demand t
  :custom
  (lsp-nix-nil-formatter ["nixfmt"]))

(use-package nix-mode
  :hook (nix-mode . lsp-deferred)
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds
   '("https://www.reddit.com/r/biology/.rss"
     "https://www.reddit.com/r/technology/.rss"
     "https://www.reddit.com/r/science/.rss"))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(random t)

(defun generate-random (keta)
  (+ (random (* 9 (expt 10 (- keta 1)))) (expt 10 (- keta 1))))

(defun anzan (keta kaisu second)
  (interactive "n桁数:\nn回数:\nn表示時間:(s/number)")
  (let* ((random-list (mapcar 'generate-random (make-list kaisu keta)))
	 (sum (apply '+ random-list)))
    (message "")
    (sit-for 1)
    (dolist (random-number random-list)
      (message (int-to-string random-number))
      (sit-for second)
      (message "")
      (sit-for 0.05))
    (if (= (read-number "答え:") sum)
	(message "正解")
      (message (format "不正解だ。練習したまえ。(正解は「%d」)" sum)))))

(defun anzan-loop (keta kaisu second)
  (interactive "n桁数:\nn回数:\nn表示時間:(s/number)")
  (anzan keta kaisu second)
  (read-char)
  (anzan-loop keta kaisu second))

(defun generate-random-signed (keta)
  (* (generate-random keta) (if (zerop (random 2)) 1 -1)))

(defun anzan2 (keta kaisu)
  (interactive "n桁数:\nn回数:")
  (let* ((random-list (mapcar 'generate-random (make-list kaisu keta)))
	 (sum (apply '+ random-list))
	 (buf (get-buffer-create "This is a pen.")))
    (switch-to-buffer buf)
    (erase-buffer)
    (dolist (random-number random-list)
      (insert (format "%d\n" random-number)))
    (if (= (read-number "答え:") sum)
	(message "正解")
      (message (format "不正解だ。練習したまえ。(正解は「%d」)" sum)))))

(defun anzan2-loop (keta kaisu)
  (interactive "n桁数:\nn回数:")
  (anzan2 keta kaisu)
  (read-char)
  (anzan2-loop keta kaisu))

;; (defun digits-of (num)
;;   "整数 NUM を各桁の数字のリストに変換する。
;; 負の数の場合も正の桁のリストを返す。"
;;   (mapcar #'string-to-number
;;           (split-string (number-to-string (abs num)) "" t)))
;; 
;; (defun convert-number-to-soroban (number)
;;   (let ((a (reverse (digits-of number))))
;;     ))

(defun log-words-read-to-csv ()
  "Count words in the current buffer and log them with the date to a CSV file."
  (interactive)
  (let* ((words (count-words (point-min) (point-max)))
         (date (format-time-string "%Y/%m/%d"))
         (log-line (format "%d, %s\n" words date))
         (log-file "~/org/word-reading-log.csv")) ; You can change the file path here
    (with-temp-buffer
      (insert log-line)
      (append-to-file (point-min) (point-max) log-file))
    (message "Logged %d words read on %s" words date)))

(global-set-key (kbd "C-c w") 'log-words-read-to-csv)

(setq inhibit-startup-screen t)
(setq browse-url-browser-function 'eww-browse-url)
(global-display-line-numbers-mode 1)
(electric-pair-mode 1)
(display-time-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
