;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Setup some better Emacs defaults
    sudoku                          ;; Sudoku game in Emacs
    elpy                            ;; Emacs Lisp Python Environment
    ein                             ;; Emacs iPython Notebook
    py-autopep8                     ;; Run autopep8 on save
    blacken                         ;; Black formatting on save
    flycheck                        ;; On the fly syntax checking
    ido-hacks                       ;; Various hacks for IDO mode
    magit                           ;; Git integration
    markdown-mode                   ;; Markdown file handing
    markdown-preview-mode           ;; Markdown preview handler
    material-theme                  ;; Theme
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ====================================
;; Basic Customization
;; ====================================

;; Interactively Do, replaces switch-buffer and find-file functions
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;; Guess context for FFAP
(setq ido-use-filename-at-point 'guess)

;; Create new buffers always
(setq ido-create-new-buffer 'always)

;; Order mini-buffer list
(setq ido-file-extensions-order '(".py" ".md" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

;; Load the theme and set linnum mode
(load-theme 'material t)    ;; Load material theme
(global-linum-mode t)       ;; Enable line numbers globally
(global-hl-line-mode 1)     ;; Highlight current line

;; Set default frame title to Emacs <version> <current file>
;; When Emacs is iconified, set it's title to Emacs - <current buffer>
(setq-default frame-title-format (list "Emacs " emacs-version " %f"))
(setq-default icon-title-format "Emacs - %b")

;; Hid the startup message
(setq inhibit-startup-message t)

;; ====================================
;; DEVELOPMENT SETUP
;; ====================================
;; Enable elpy
(elpy-enable)

;; Use IPython for REPL
;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")
 
;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable Autopep8
;; (require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Enable Black
;(add-hook 'python-mode-hook 'blacken-mode)

;; GNUServ
;(require 'gnuserv)
;(gnuserv-start)
;(setq gnuserv-frame (selected-frame))
;(server-start)



;; User-Defined init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(desktop-save-mode t)
 '(display-time-mode t)
 '(package-selected-packages
   (quote
    (flycheck sudoku material-theme elpy better-defaults)))
 '(python-shell-completion-native-disabled-interpreters (quote ("python" "pypy" "ipython")))
 '(save-place t)
 '(show-paren-mode t)
 '(sudoku-download-method "lynx")
 '(sudoku-puzzle-source "built-in")
 '(sudoku_download t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "SRC" :slant normal :weight normal :height 139 :width normal)))))
