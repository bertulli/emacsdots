
;;; Code:
(require 'projectile)
(require 'eshell)
(require 'lsp-java)

(defun get-main-method-list ()
  "Scan the project for main methods to run."
  (interactive)
  (let ((project-root (projectile-acquire-root))
	(output-buffer (get-buffer-create "*java-grep*")))
    (shell-command (format "grep --include=\\*.java -rnwl \'%s\' -e \'%s\'"
			   project-root
			   "public[[:space:]]\\+static[[:space:]]\\+void[[:space:]]\\+main")
		   output-buffer
		   output-buffer)
    (with-current-buffer output-buffer
      (progn (beginning-of-buffer)
	     (while (re-search-forward "^.*/src/main/java/" nil t)
	       (delete-region (line-beginning-position) (point)))
	     (let* ((buffer-content (buffer-substring-no-properties (point-min) (point-max)))
		    (basic-candidates (delete "" (split-string buffer-content "\n")))
		    (trimmed-candidates (mapcar
					 (lambda (candidate) (string-remove-suffix ".java"
										   ;; (string-remove-prefix
										   ;;  (concat project-root "src/main/java/")
										   candidate))
					 basic-candidates))
		    (package-candidates (mapcar
					 (lambda (candidate) (replace-regexp-in-string "/" "\." candidate))
					 trimmed-candidates)))
	       package-candidates
	       )
	     ))))

;; (when (string-match "[ \t]*$" test-str)
;;   (message (concat "[" (replace-match "" nil nil test-str) "]")))

;; 					;but not encouraged
;; (replace-regexp "^.*?[0-9]:.*?seconds" "")
;; 					;prefer this
;; (while (re-search-forward "^.*?[0-9]:.*?seconds")
;;   (replace-match "" nil nil))
;; (while (re-search-forward "^.*/src/main/java/" nil t)
;;   (replace-match "" nil nil))

;; (defun mddtt ()
;;   (interactive "@*")
;;   (re-search-forward "[0-9]:")
;;   (let ((st (line-beginning-position)))
;;     (search-forward "seconds")
;;     (delete-region st (point))))

					; 
;; from https://emacs.stackexchange.com/a/14085/29817
;; code licensed under CC BY-SA 3.0 (https://creativecommons.org/licenses/by-sa/3.0/)
;; (defvar my-compilation-exit-status-code nil)
;; (defun my-compilation-exit-message-function (_process-status exit-status msg)
;;   "Trivially set `my-compilation-exit-code'."
;;   (setq my-compilation-exit-status-code exit-status)
;;   (cons msg exit-status))

;; (setq compilation-exit-message-function 'my-compilation-exit-message-function)

;; (search-forward "qwerty")

(defun run-java-main-method (mainClass)
  "Launch a separate (?) Java process running the main method of class MAINCLASS.

If launched with universal argument, waits for command line parameters."
  (interactive
   (list (completing-read "Run main method: " (get-main-method-list))))
  (let ((project-root (projectile-locate-dominating-file default-directory "pom.xml"))
	(compilation-output-buffer (get-buffer-create "*mvn-compilation*")))
    (with-current-buffer compilation-output-buffer
      (erase-buffer))
    (call-process-shell-command (format "mvn -f %s compile" project-root)
				nil
				`(,(buffer-name compilation-output-buffer) t)
				nil)
    (if (with-current-buffer compilation-output-buffer
	  (search-backward "BUILD SUCCESS" nil t))
	(progn
	  (cl-assert eshell-buffer-name)
	  (let ((default-directory project-root))
	    (let ((buf (generate-new-buffer (format "%s<%s>"
						    eshell-buffer-name
						    mainClass))))
	      (cl-assert (and buf (buffer-live-p buf)))
	      (pop-to-buffer-same-window buf)
	      (unless (derived-mode-p 'eshell-mode)
		(eshell-mode))
	      (eshell-return-to-prompt)
	      (insert (format "%s -Dfile.encoding=UTF-8 -classpath %s %s"
			      lsp-java-java-path
			      (let ((classpath-buffer (get-buffer-create "*mvn-classpath*")))
				(progn
				  (with-current-buffer "*mvn-classpath*"
				    (erase-buffer))
				  (call-process-shell-command (format "mvn -f %s dependency:build-classpath -Dmdep.includeScope=runtime" project-root)
							      nil
							      `(,(buffer-name classpath-buffer) t)
							      nil)
				  (let ((basic-classpath (with-current-buffer "*mvn-classpath*"
							   (goto-char (point-min))
							   (delete-matching-lines "\\[INFO\\]\\|\\[WARNING\\]")
							   (buffer-substring-no-properties (point-min) (- (point-max) 1)) ;; ignore ending newline
							   )))
				    (concat project-root "target/classes:" basic-classpath))))
			      mainClass))
	      ;;(insert "\n---------------------\n") causes the line to be read
	      (if current-prefix-arg
		  (insert " ")
		(eshell-send-input))
	      buf)))
      (message (format "Compilation failed! See buffer %s for details" (buffer-name compilation-output-buffer)))
      (switch-to-buffer "*mvn-compilation*"))
    ))
;;  (pop-to-buffer-same-window terminal-buffer)))


;; (make-comint-in-buffer "procProva" "*bufferProva*"
;; 		       "ls" nil "-l")


(global-set-key (kbd "C-c j") #'run-java-main-method)



;; (global-set-key (kbd "C-c g") #'get-main-method-list)

;; (with-current-buffer "*java-grep*"
;;       (let ((res '()))
;; 	(goto-char (point-min))
;; 	(while (not (eobp))
;; 	  (let ((line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
;; 	    (push line res)
;; 	    (forward-line 1)))
;; 	(print res))
;;       )

;; (defun get-main-method-list ()
;;   "Scan the project for main methods to run."
;;   (interactive)
;;   (let* ((project-root (projectile-acquire-root))
;; 	 (output-buffer (get-buffer-create "*java-grep*")))
;;     (async-shell-command (format "grep --include=\\*.java -rnwl \'%s\' -e \'%s\'"
;; 				 project-root
;; 				 "public[[:space:]]\\+static[[:space:]]\\+void[[:space:]]\\+main")
;; 			 output-buffer
;; 			 output-buffer)
;;     (with-current-buffer output-buffer
;;       (let ((buffer-content (buffer-string)))
;; ;;	(print buffer-content) ;; debug IT PRINTS NOTHING!
;; 	(set-text-properties 0 (length buffer-content) nil buffer-content)
;; 	(split-string buffer-content "\n")))))

;; (message "I'm in %s" (current-buffer))
;; (print (cl-loop until (eobp)
;;          collect (prog1 (buffer-substring-no-properties
;;                          (line-beginning-position)
;;                          (line-end-position))
;; 			 (forward-line 1))))

;; (goto-char (point-min))
;;       (print (buffer-substring-no-properties (line-beginning-position) (line-end-position)))

;;(add-to-list 'display-buffer-alist '("*java-grep*" display-buffer-no-window (nil)))
(add-to-list 'display-buffer-alist '("*mvn-classpath*" display-buffer-no-window (nil)))


;; (split-string "Ciao
;; a
;; tutti"
;; 	      "\n")

;; (rgrep "public[[:space:]]\\+static[[:space:]]\\+void[[:space:]]\\+main"
;;        "*.java"
;;        (expand-file-name "~/akka/")
;;        t)

;; "public[[:space:]]+static[[:space:]]+void[[:space:]]+main"


;; (async-shell-command (format "mvn exec:java@%s" mainClass))



;; (defun populate-main-method-list ()
;;   "Scan the project for main methods to run."
;;   (interactive)
;;   (let* ((project-root (expand-file-name "~/akka/")) ;;(projectile-acquire-root))
;; 	 (output-buffer (get-buffer-create "*java-grep*")))
;;     (shell-command (format "grep --include=\\*.java -rnwl \'%s\' -e \'%s\'"
;; 				 project-root
;; 				 "public[[:space:]]\\+static[[:space:]]\\+void[[:space:]]\\+main")
;; 			 output-buffer
;; 			 output-buffer)
;;     (buffer-name output-buffer)))

;; (defun convert-main-method-list (output-buffer-name)
;;   "Scan the project for main methods to run."
;;   (interactive)
;;   (with-current-buffer output-buffer-name
;;     (split-string
;;      (buffer-substring-no-properties (point-min) (point-max))
;;      "\n")))

;; (defun complete-function ()
;;   (interactive)
;;   (delete "" (convert-main-method-list (populate-main-method-list))))
