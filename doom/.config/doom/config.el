(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "JetBrains Mono" :size 10.0))

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle eshell split"            "e" #'+eshell/toggle
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle line numbers"            "l" #'doom/toggle-line-numbers
       :desc "Toggle markdown-view-mode"      "m" #'cstm/toggle-markdown-view
       :desc "Toggle truncate lines"          "t" #'toggle-truncate-lines))
       ;; :desc "Toggle treemacs"                "T" #'+treemacs/toggle
       ;; :desc "Toggle vterm split"             "v" #'+vterm/toggle))

(map! :leader
      (:prefix ("o" . "open here")
       ;; :desc "Open eshell here"    "e" #'+eshell/here
       :desc "Open ghostel here"   "v" #'ghostel))

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.1)))))

(defun cstm/toggle-markdown-view ()
  "Toggle between `markdown-mode' and `markdown-view-mode'."
  (interactive)
  (if (eq major-mode 'markdown-view-mode)
      (markdown-mode)
    (markdown-view-mode)))

(setq org-directory "~/org/")
(setq org-modern-table-vertical 1)
(setq org-modern-table t)
(add-hook 'org-mode-hook #'hl-todo-mode)

(custom-theme-set-faces!
'doom-gruvbox
'(org-level-8 :inherit outline-3 :height 1.0)
'(org-level-7 :inherit outline-3 :height 1.0)
'(org-level-6 :inherit outline-3 :height 1.1)
'(org-level-5 :inherit outline-3 :height 1.2)
'(org-level-4 :inherit outline-3 :height 1.3)
'(org-level-3 :inherit outline-3 :height 1.4)
'(org-level-2 :inherit outline-2 :height 1.5)
'(org-level-1 :inherit outline-1 :height 1.6)
'(org-document-title  :height 1.8 :bold t :underline nil))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode) ;; Set display line numbers to relative
(setq-default compile-command "") ;; Set default compile-command to empty
(setq confirm-kill-emacs nil)        ;; Don't confirm on exit
(setq bookmark-save-flag 1)
(add-to-list 'default-frame-alist '(alpha-background . 75)) ;; Set emacs opacity to 75

(defun cstm/disable-line-numbers ()
  "Disable line numbers in current buffer."
  (display-line-numbers-mode -1))

;; Core: browser + preview
(add-hook 'dired-mode-hook #'cstm/disable-line-numbers)
(add-hook 'dirvish-mode-hook #'cstm/disable-line-numbers)
(add-hook 'dirvish-directory-view-mode-hook #'cstm/disable-line-numbers)
(add-hook 'dirvish-special-preview-mode-hook #'cstm/disable-line-numbers)
(add-hook 'image-mode-hook #'cstm/disable-line-numbers)

;; eshell and pdf
(add-hook 'eshell-mode-hook #'cstm/disable-line-numbers)
(after! pdf-tools
  (add-hook 'pdf-view-mode-hook #'cstm/disable-line-numbers))

;; Hygiene for other non-text previews
(add-hook 'archive-mode-hook #'cstm/disable-line-numbers)
(add-hook 'tar-mode-hook #'cstm/disable-line-numbers)
(add-hook 'doc-view-mode-hook #'cstm/disable-line-numbers)

(use-package! ghostel
  :bind (("C-x m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl"))))
  :config
  (add-to-list 'ghostel-eval-cmds '("magit-status-setup-buffer" magit-status-setup-buffer)))

(use-package! evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))

(add-hook 'ghostel-mode-hook #'cstm/disable-line-numbers) ;; ghostel + claude (ghostel backend) no line numbers

(map! :leader
      :desc "OpenCode"
      "o o" #'opencode)

(after! opencode
 ;; Open OpenCode in the current window, not as a popup below.
 (defun cstm/opencode-open-project-same-window (orig-fn directory)
   (let ((display-buffer-overriding-action
          '((display-buffer-same-window))))
     (funcall orig-fn directory)))

 (advice-add 'opencode-open-project
             :around
             #'cstm/opencode-open-project-same-window)

 (add-hook 'opencode-session-mode-hook #'cstm/disable-line-numbers)
 (add-hook 'opencode-session-control-mode-hook #'cstm/disable-line-numbers)) ;; chat + session list

(use-package! claude-code-ide
  :config
  (setq claude-code-ide-terminal-backend 'ghostel)
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

(after! claude-code-ide
  (map! :leader
        :desc "Claude Code"
        "o c" #'claude-code-ide-menu))

(after! jsonc-mode
  (add-to-list 'auto-mode-alist
               '("\\.jsonc\\'" . jsonc-mode)))
