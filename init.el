(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cmake-mode magit lsp-ui groovy-mode gradle-mode flycheck which-key lsp-java muse yasnippet-snippets yasnippet company-irony-c-headers lsp-mode company-irony irony company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-link ((t (:inherit link :underline nil))))
 '(org-target ((t (:underline nil)))))
;;--------------
;; Enable MELPA
;;-------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;------------
;; Various
;;-------------
(define-key prog-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
(which-key-mode)
(global-flycheck-mode)


;;--------------
;; Magit
;;--------------
;;(eval-after-load 'magit
;;  (setq magit-view-git-manual-method 'woman))

;;-----------------
;; Muse
;;--------------
(add-hook 'muse-mode-hook 'toggle-word-wrap)

;;--------------
;; Org
;;------------
(add-hook 'org-mode-hook 'visual-line-mode)
(setf org-highlight-links '(bracket plain radio tag date footnote))
;;-----------------
;; YASnippet
;;-----------------
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook 'yas-minor-mode)

;;------------------
;; Java-lsp
;;-----
(require 'lsp-java)
(let ((java-home (getenv "JAVA_HOME"))
      (java-path (concat (getenv "JAVA_HOME") "/bin/java")))
    (setq lsp-java-java-path java-path ;;(concat (getenv "JAVA_HOME") "/bin/java")
	  lsp-java-import-gradle-java-home java-path;; (concat (getenv "JAVA_HOME") "/bin/java")
	  lsp-java-configuration-runtimes ( [(:name "JavaSE-16"
                                                       :path "/usr/lib/jvm/java-16-openjdk"
                                                       :default t)])
	  lsp-java-vmargs (list "-noverify" "--enable-preview")
      )
    )

;;--------------
;; Gradle
;;---------------
(require 'gradle-mode)
(add-hook 'java-mode-hook 'gradle-mode) ;;'(lambda() (gradle-mode 1))
(defun my-gradle-build-and-run ()
  "Execute the gradle build and run commands."
  (interactive)
  (gradle-run "build run"))
(define-key gradle-mode-map (kbd "C-c C-r") 'my-gradle-build-and-run)

(define-key gradle-mode-map (kbd "C-c C-b") 'gradle-build)
;;----------------
;; Language Server Protocol
;;--------------
(add-hook 'java-mode-hook #'lsp)
;; apparently, this must be done before loading in any way lsp-mode
(setq lsp-keymap-prefix "C-c l")
(define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
;; this must be called after to let which-key see the new prefix, think
;(add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
(define-key lsp-mode-map (kbd "M-RET") 'lsp-execute-code-action)
;;suggested by lsp-java doc
(setq lsp-completion-enable-additional-text-edit nil)

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

;;copied from https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/
;;probably is better
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; (eval-after-load 'lsp-mode (setq 'lsp-modeline-code-actions-segments '(icon name)))

;;-------------------
;; Company (should be called after lsp-mode?)
;;------------------
(add-hook 'prog-mode-hook 'company-mode)
(define-key prog-mode-map (kbd "C-M-i") 'company-complete)
(eval-after-load 'comapny '(define-key company-mode-map (kbd "<C-tab>") 'company-complete))
(eval-after-load 'company '(define-key company-active-map (kbd "<tab>") 'company-complete))
(eval-after-load 'company '(add-to-list 'company-backends 'company-capf))
(setq company-minimum-prefix-length 1)

;;---------------
;; Irony
;;----------------
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;-------------------
;; 
;;-------------
;; (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

;;-------------
;; Company-irony-c-headers
;; Company-irony
;;-------------------
;; (require 'company-irony-c-headers)
;; (eval-after-load 'company '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))

;; (setq company-backends '((company-irony-c-headers company-irony)
;;  company-eclim company-cmake company-capf company-files))
