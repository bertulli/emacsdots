(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/agenda.org"))
 '(package-selected-packages
   '(eldoc-cmake ivy auctex eglot-java projectile java-snippets eglot javadoc-lookup maven-test-mode mvn cmake-mode magit lsp-ui groovy-mode gradle-mode flycheck which-key lsp-java muse yasnippet-snippets yasnippet company-irony-c-headers lsp-mode company-irony irony company))
 '(safe-local-variable-values
   '((projectile-project-configure-cmd . "cmake -S . -B build -D CMAKE_EXPORT_COMPILE_COMMANDS=ON")
     (projectile-project-configure-cmd . "cmake -B build -D CMAKE_EXPORT_COMPILE_COMMANDS=ON")
     (projectile-project-configure-cmd . "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"))))
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
(add-hook 'cmake-mode-hook 'eldoc-cmake-enable)


(defun my/ide-setup ()
  "Set up an environment like an IDE."
  (interactive)
  (progn
    (lsp-treemacs-symbols)
    (treemacs)))

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.5
      company-minimum-prefix-length 2
      lsp-idle-delay 0.5)  ;; clangd is fast

;;------------
;; Ivy
;;----------
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;;--------------
;; Ace-window
;;-------------
(defun ace-window-manual-dispatch (arg)
  "Calls `ace-window' with ARG asking for the dispatch, even if `aw-dispatch-always' is nil.

This could be useful to use the advanced commands"
  (interactive "p")
(let ((aw-dispatch-always t))
  (ace-window arg)
  ))

(global-set-key (kbd "M-o") 'ace-window)
(ace-window-display-mode 1)
(global-set-key (kbd "C-M-o") 'ace-window-manual-dispatch)
;;--------------
;; Magit
;;--------------
;;(eval-after-load 'magit
;;  (setq magit-view-git-manual-method 'woman))

;;-----------------
;; AucTeX
;;--------------
;;suggested from info file
(eval-after-load 'auctex
  (progn
    (setq TeX-auto-save t)
    (setq TeX-parse-self t)
    (setq TeX-debug-bad-boxes t)))
;;---------------
;; Eglot-java
;;------------
(eval-after-load 'eglot-java
  (progn
    (require 'eglot-java)
    '(eglot-java-init)))
(require 'cc-mode)
(define-key java-mode-map (kbd "C-c j r") 'eglot-java-run-main)
;;-----------------
;; Muse
;;--------------
(add-hook 'muse-mode-hook 'toggle-word-wrap)

;;--------------
;; Org
;;------------
(add-hook 'org-mode-hook 'visual-line-mode)
(setf org-highlight-links '(bracket plain radio tag date footnote))
;; these keybindings are suggested by the org guide
;;(global-set-key (kbd "C-c l") #'org-store-link) ;; it conflicts with lsp-mode
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;;-----------------
;; YASnippet
;;-----------------
(require 'yasnippet)
(yas-reload-all)
(yas-global-mode)

;;--------------
;;Projectile
;;-------------------
(require 'projectile)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)
;;----------------------
;; Maven
;;-------------------
(require 'mvn)
(defun mvn-run ()
    "Run the project main, based on the POM.xml

Looks up in the POM.xml the executable to launch, then executes it.  To run a differnt executable or main method, mvn exec:exec must be called from command line"
  (interactive)
  (mvn "exec:exec")
  )

;; not sure this is gonna work

;; (defun my-java-run ()
;;   "Run the run.sh script in the project root"
;;   (interactive)
;;   (  (let ((project-root-directory (mvn-find-root '() mvn-build-file-name)))
;;     (if project-root-directory
;;         (shell-command (concat project-root-directory "run.sh"))
;;       (message "Couldn't find a maven project.")))))



;;---------------
;; Maven test mode
;;---------------
(require 'maven-test-mode)

;; defined in Maven section
;;(define-key maven-test-mode-map (kbd "C-c C-r") 'mvn-run)

;;------------------
;; Java-lsp
;;-----
(require 'lsp-java)
(require 'dap-java)
(let ((java-home (getenv "JAVA_HOME"))
      (java-path (concat (getenv "JAVA_HOME") "/bin/java")))
    (setq lsp-java-java-path java-path ;;(concat (getenv "JAVA_HOME") "/bin/java")
	  lsp-java-import-gradle-java-home java-path;; (concat (getenv "JAVA_HOME") "/bin/java")
	   ;; lsp-java-configuration-runtimes ( '[(:name "JavaSE-11"
           ;;                                              :path "/usr/lib/jvm/java-11-openjdk"
           ;;                                              :default t)])
	   ;; lsp-java-vmargs (list "-noverify" "--enable-preview")
      )
    )

;;-------------
;; Dap mode
;;--------------
(require 'dap-mode)
(eval-after-load 'lsp-mode
  (dap-auto-configure-mode))
(defun my-dap-debug-compile-run ()
  "Compile the project using maven 'mvn compile' and Run it.

Uses the simple Java Run Configuration"
  (interactive)
  (dap-debug   (list :name "Java Run Configuration"
        :type "java"
        :request "launch"
        :args ""
        :cwd nil
        :stopOnEntry :json-false
        :host "localhost"
        :request "launch"
        :modulePaths []
        :classPaths nil
        :projectName nil
        :mainClass nil
	:dap-compilation "mvn compile"
	:dap-compilation-dir (mvn-find-root mvn-build-file-name))
	       )
  )

;; (defun my-dap-debug-run ()
;;   "Run the project.

;; Uses the simple Java Run Configuration"
;;   (interactive)
;;   (dap-debug   (list :name "Java Run Configuration"
;;         :type "java"
;;         :request "launch"
;;         :args ""
;;         :cwd nil
;;         :stopOnEntry :json-false
;;         :host "localhost"
;;         :request "launch"
;;         :modulePaths []
;;         :classPaths nil
;;         :projectName nil
;;         :mainClass nil
;; 	))
;;   )

;; (define-key maven-test-mode-map (kbd "C-c C-c C-r") 'my-dap-debug-compile-run)
;; (define-key maven-test-mode-map (kbd "C-c C-r") 'my-dap-debug-run)

;; (dap-register-debug-template "My Runner"
;;                              (list :type "java"
;;                                    :request "launch"
;;                                    :args ""
;;                                    :vmArgs "-ea -Dmyapp.instance.name=myapp_1"
;;                                    :projectName "myapp"
;;                                    :mainClass "com.domain.AppRunner"
;;                                    :env '(("DEV" . "1"))))

;;------------------
;; Eglot
;;------------------
(require 'eglot)
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
;;(add-hook 'java-mode-hook #'eglot-ensure)
;;use flychech instead of flymake
(add-to-list 'eglot-stay-out-of 'flymake)
;;if not managed via global-flycheck-mode, uncomment
;;(add-hook 'eglot-managed-mode-hook 'flycheck-mode)

;; found on https://cestlaz.github.io/post/using-emacs-74-eglot/
;; the regexp should match files like org.eclipse.equinox.launcher_1.6.300.v20210813-1054.jar
(defconst my-eclipse-jdt-home
  (concat (expand-file-name "~/.emacs.d/.cache/lsp/eclipse.jdt.ls/plugins/")
	  (car (seq-filter (lambda (string) (string-match-p "org.eclipse.equinox.launcher[^.].*jar$" string))
			   (directory-files "~/.emacs.d/.cache/lsp/eclipse.jdt.ls/plugins/")))
	  ))

(defun my-eglot-eclipse-jdt-contact (interactive)
  "Contact with the jdt server input INTERACTIVE."
  (let ((cp (getenv "CLASSPATH")))
    (setenv "CLASSPATH" (concat cp ":" my-eclipse-jdt-home))
    (unwind-protect (eglot--eclipse-jdt-contact nil)
      (setenv "CLASSPATH" cp))))
(setcdr (assq 'java-mode eglot-server-programs) #'my-eglot-eclipse-jdt-contact)
;;(add-hook 'java-mode-hook 'eglot-ensure)
;;suggested by the repo
(define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
(define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
(define-key eglot-mode-map (kbd "C-c h") 'eldoc)
;;--------------
;; Gradle
;;---------------
(require 'gradle-mode)
;;(add-hook 'java-mode-hook 'gradle-mode) ;;'(lambda() (gradle-mode 1))
(defun my-gradle-build-and-run ()
  "Execute the gradle build and run commands."
  (interactive)
  (gradle-run "build run"))
(define-key gradle-mode-map (kbd "C-c C-r") 'my-gradle-build-and-run)

(define-key gradle-mode-map (kbd "C-c C-b") 'gradle-build)
;;----------------
;; Language Server Protocol
;;--------------
;;(add-hook 'java-mode-hook #'lsp)
;; apparently, this must be done before loading in any way lsp-mode
(setq lsp-keymap-prefix "C-c l")
(define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
;; this must be called after to let which-key see the new prefix, think
(add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
(define-key lsp-mode-map (kbd "M-RET") 'lsp-execute-code-action)
;;suggested by lsp-java doc
(setq lsp-completion-enable-additional-text-edit nil)

;;(add-hook 'c-mode-hook 'lsp)
;;(add-hook 'c++-mode-hook 'lsp)

;;copied from https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/
;;probably is better
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; (eval-after-load 'lsp-mode (setq 'lsp-modeline-code-actions-segments '(icon name)))

;;---------------
;; lsp-ui
;;--------------
(eval-after-load 'lsp
  (eval-after-load 'lsp-ui
    (setq lsp-ui-sideline-show-hover t)
    ))

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
