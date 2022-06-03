
;;; Code:
(require 'projectile)
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
    (with-current-buffer (buffer-name output-buffer)
      (let* ((buffer-content (buffer-substring-no-properties (point-min) (point-max)))
	     (basic-candidates (delete "" (split-string buffer-content "\n")))
	     (trimmed-candidates (mapcar
				  (lambda (candidate) (string-remove-suffix ".java"
									    (string-remove-prefix
									     (concat project-root "src/main/java/") candidate)))
				  basic-candidates))
	     (package-candidates (mapcar
				  (lambda (candidate) (replace-regexp-in-string "/" "\." candidate))
				  trimmed-candidates)))
	package-candidates
	)
      )))

					; 

(defun run-java-main-method (mainClass)
  "Launch a separate (?) Java process running the main method of class MAINCLASS."
  (interactive
   (list (completing-read "Run main method: " (get-main-method-list))))
  (let ((terminal-buffer (format "*java<%s>*" mainClass))
	(project-root (projectile-acquire-root)))
    (shell-command (format "mvn -f %s compile" project-root))
    (apply 'make-comint-in-buffer mainClass
	   terminal-buffer
	   lsp-java-java-path
	   nil
	   (list
	    "-Dfile.encoding=UTF-8"
	    "-classpath"
	    (progn
	      (eshell-command (format "mvn -f %s dependency:build-classpath -Dmdep.includeScope=runtime > (get-buffer-create \"*mvn-classpath*\")" project-root))
	      (let ((basic-classpath (with-current-buffer "*mvn-classpath*"
				       (goto-char (point-min))
				       (delete-matching-lines "\\[INFO\\]\\|\\[WARNING\\]")
				       (buffer-substring-no-properties (point-min) (- (point-max) 1)) ;; ignore ending newline
				       )))
		(concat (projectile-acquire-root) "target/classes:" basic-classpath)))
	    mainClass))
    (pop-to-buffer-same-window terminal-buffer)))


;; (make-comint-in-buffer "procProva" "*bufferProva*"
;; 		       "ls" nil "-l")

;; (cl-assert eshell-buffer-name)
;; (let ((buf (generate-new-buffer (format "%s<%s>"
;; 					eshell-buffer-name
;; 					name))))

;;   (cl-assert (and buf (buffer-live-p buf)))
;;   (pop-to-buffer-same-window buf)
;;   (unless (derived-mode-p 'eshell-mode)
;;     (eshell-mode))
;;   buf)
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

(add-to-list 'display-buffer-alist '("*java-grep*" display-buffer-no-window (nil)))


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
