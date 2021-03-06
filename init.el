;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  This code is free software: you can redistribute it and/or		;;
;;  modify it under the terms of the GNU General Public License as	;;
;;  published by the Free Software Foundation, either version 3 of	;;
;;  the License, or (at your option) any later version.			;;
;; 									;;
;; This code is distributed in the hope that it will be useful,		;;
;; but WITHOUT ANY WARRANTY; without even the implied warranty of	;;
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	;;
;; General Public License for more details.				;;
;; 									;;
;; You should have received a copy of the GNU General Public License	;;
;; along with this code. If not, see					;;
;; <https://www.gnu.org/licenses/>.					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/home/alessandro/prov.org" "/home/alessandro/middleware/middleware_projectA/MPI_simulator/MPI-proj.org" "/home/alessandro/tesi/thesis-proj-roadmap.org" "/home/alessandro/agenda.org"))
 '(org-use-sub-superscripts '{})
 '(package-selected-packages
   '(rustic consult citar gnu-elpa-keyring-update flycheck-rust rust-mode bug-hunter interaction-log vterm pdf-tools org-roam tree-sitter-langs tree-sitter window-jump windsize org-sticky-header realgud quickrun olivetti corfu-doc corfu orderless vertico org ivy-bibtex company-reftex ebib systemd helpful cdlatex command-log-mode gh-md meghanada flycheck-plantuml plantuml-mode cider flycheck-lilypond license-snippets lice bison-mode hercules major-mode-hydra ivy-hydra transient-dwim eldoc-cmake ivy auctex eglot-java projectile java-snippets eglot javadoc-lookup maven-test-mode mvn cmake-mode magit lsp-ui groovy-mode gradle-mode flycheck which-key lsp-java muse yasnippet-snippets yasnippet company-irony-c-headers lsp-mode company-irony irony company))
 '(safe-local-variable-values
   '((projectile-project-compilation-cmd . "cmake --build ~/C++/elr1/build")
     (projectile-project-configure-cmd . "cmake -S ~/C++/elr1 -B ~/C++/elr1/build -D CMAKE_BUILD_TYPE=Debug")
     (projectile-project-compilation-cmd . "cmake --build ~/C++/cmake-train/build")
     (projectile-project-configure-cmd . "cmake -S ~/C++/cmake-train -B ~/C++/cmake-train/build -D CMAKE_BUILD_TYPE=Debug")
     (projectile-project-configure-cmd . "cmake -B build -D CMAKE_EXPORT_COMPILE_COMMANDS=ON")
     (projectile-project-configure-cmd . "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;--------------
;; Enable MELPA
;;-------------

;; RealGUD ------------------------
;; (require 'realgud)
;; (global-set-key (kbd "C-c p x d")
;; 		(lambda () (interactive)
;; 		  (projectile-with-default-dir (projectile-acquire-root)
;; 		    (realgud:gdb))))

;; Windows --------------------
(require 'windsize)
;;(windsize-default-keybindings)
(global-set-key (kbd "M-S-<left>") #'windsize-left)
(global-set-key (kbd "M-S-<right>") #'windsize-right)
(global-set-key (kbd "M-S-<up>") #'windsize-up)
(global-set-key (kbd "M-S-<down>") #'windsize-down)

(setq windsize-cols 1)
(setq windsize-rows 1)

(require 'window-jump)
(global-set-key (kbd "M-<left>") #'window-jump-left)
(global-set-key (kbd "M-<right>") #'window-jump-right)
(global-set-key (kbd "M-<up>") #'window-jump-up)
(global-set-key (kbd "M-<down>") #'window-jump-down)


;; Avy ------------
(require 'avy)
(avy-setup-default)
(global-set-key (kbd "M-SPC") 'avy-goto-char-timer)
(setq avy-style 'pre)
(setq avy-all-windows nil) ; or t or 'all-frames

;; Consult --------
(define-key isearch-mode-map (kbd "C-M-s") #'consult-line)
(global-set-key (kbd "C-h a") #'consult-apropos)
(setq xref-show-xrefs-function #'consult-xref)
(setq xref-show-definitions-function #'consult-xref)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;;------------
;;; Various
;;;-------------
(global-set-key (kbd "C-x C-c") #'save-buffers-kill-emacs)
;;(setq debug-on-error t)

(setq gnus-select-method '(nntp "ger.gmane.org"))
(setq confirm-kill-emacs #'y-or-n-p)
(tool-bar-mode 0)
(define-key prog-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-flycheck-mode)
(add-hook 'cmake-mode-hook 'eldoc-cmake-enable)
(add-hook 'markdown-mode-hook 'visual-line-mode)

(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)


(setq tab-always-indent 'complete)

;; Eshell

(require 'eshell)
(defun my/eshell (name)
  "Create a new eshell buffer, appending NAME to it."

  ;; B
  ;; A buffer name. The buffer need not exist. By default, uses the name of a recently used buffer other than the current buffer. Completion, Default, Prompt.

  ;; M
  ;; Arbitrary text, read in the minibuffer using the current buffer???s input method, and returned as a string (see Input Methods in The GNU Emacs Manual). Prompt.

  ;; s
  ;; Arbitrary text, read in the minibuffer and returned as a string (see Text from Minibuffer). Terminate the input with either C-j or RET. (C-q may be used to include either of these characters in the input.) Prompt.

  ;; S
  ;; An interned symbol whose name is read in the minibuffer. Terminate the input with either C-j or RET. Other characters that normally terminate a symbol (e.g., whitespace, parentheses and brackets) do not do so here. Prompt.

  (interactive "MName of the eshell session: ")
  (cl-assert eshell-buffer-name)
  (let ((buf (generate-new-buffer (format "%s<%s>"
					  eshell-buffer-name
					  name))))
    
    (cl-assert (and buf (buffer-live-p buf)))
    (pop-to-buffer-same-window buf)
    (unless (derived-mode-p 'eshell-mode)
      (eshell-mode))
    buf))

(defun my/eshell-wrap (arg)
  "Wrapper to call eshell. ARG is taken as universal argument.

With zero or one universal arguments simply calls eshell with it.
With two universal arguments call `my/eshell'."
  (interactive "P")
  (if
      (equal (prefix-numeric-value arg) 16)
      (call-interactively #'my/eshell)
    (call-interactively 'eshell)
    ))

(global-set-key (kbd "C-c e") #'my/eshell-wrap)
(global-set-key (kbd "C-c t") #'(lambda () (interactive) (term "/bin/bash")))
(global-set-key (kbd "C-c s") #'shell)
(global-set-key (kbd "C-c v") #'vterm)

;;for artist mode
(add-hook 'artist-mode-hook (lambda () (setq indent-tabs-mode nil)))

(setq sentence-end-double-space nil)
(show-paren-mode)

;;indentation
(defun indent-buffer ()
  "Indent all the current buffer, using built-in `indent-region'."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key (kbd "C-M-|") 'indent-buffer)

;; Lice
(require 'lice)
(setq lice:comment-style 'box)

;; Lilypond
(load-library "lilypond-mode")

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

;;--------------
;; Help - transient-dwim
;;--------------
(which-key-mode 1)
;;(global-set-key (kbd "M-SPC") #'major-mode-hydra)
(global-set-key (kbd "C-M-SPC") #'which-key-show-major-mode)
(require 'ivy-hydra)
(global-set-key (kbd "M-=") 'transient-dwim-dispatch)

;; Helpful ---------------
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h M-.") #'helpful-at-point)

;;----------------
;; Bison
;;----------------
(add-to-list 'auto-mode-alist '("\\.yy\\'" . bison-mode))
;;(add-to-list 'auto-mode-alist '("\\.ll\\'" . flex-mode))
(add-to-list 'auto-mode-alist '("\\.lex\\'" . flex-mode))

;;-----------
;; LLVM
;;----------
;;taken inspiration from https://emacs.stackexchange.com/questions/34698/loading-and-executing-el-file-if-it-exists-on-startup
(let* ((emacs-llvm-dir "~/.emacs.d/llvm/")
      (emacs-llvm-file (concat emacs-llvm-dir "emacs.el")))
  (setq load-path
	(cons (expand-file-name emacs-llvm-dir) load-path))
  (require 'llvm-mode)
  (require 'tablegen-mode)
  
  (if (file-exists-p emacs-llvm-file)
      (load-file emacs-llvm-file)
    ;;  (error "ERROR: couldn't find `%s'" emacs-llvm-file)
    ;;(signal 'file-missing emacs-llvm-file)
    )
  )

;;------------
;; Ivy
;;----------
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq ivy-count-format "(%d/%d) ")

;;------------------
;; Vertico
;;----------------
(require 'vertico)
(vertico-mode)

;; from https://github.com/minad/vertico
;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;; Vertico commands are hidden in normal buffers.
(setq read-extended-command-predicate
      #'command-completion-default-include-p)
;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)
(defun crm-indicator (args)
  "Taken from the vertico repo"
  (cons (format "[CRM%s] %s"
                (replace-regexp-in-string
                 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                 crm-separator)
                (car args))
        (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(define-key vertico-map (kbd "TAB") #'minibuffer-complete)
;; (define-key vertico-map (kbd "RET") #'vertico-exit)
(define-key vertico-map (kbd "C-<tab>") #'vertico-insert)
(define-key minibuffer-mode-map (kbd "C-<tab>") #'vertico-insert)
(define-key minibuffer-local-map (kbd "C-<tab>") #'vertico-insert)
(define-key vertico-map (kbd "<backspace>") #'vertico-directory-delete-char)
(define-key vertico-map (kbd "C-<backspace>") #'delete-backward-char)
(require 'savehist)
(savehist-mode)

;; Orderless----------
(setq completion-styles '(basic substring orderless partial-completion emacs22))
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;;--------------
;; Corfu
;;---------------
(require 'corfu)
(global-corfu-mode 1)

(require 'lsp-mode)
;;for LSP
(setq lsp-completion-provider :none)
;; (defun corfu-lsp-setup ()
;;   "Set up Corfu for LSP.

;; Taken from https://www.reddit.com/r/emacs/comments/ql8cyp/comment/hj2k2lh/?utm_source=share&utm_medium=web2x&context=3"
;;   (setq-local ;;completion-styles '(orderless)
;; 	      completion-category-defaults nil))
;; (add-hook 'lsp-mode-hook #'corfu-lsp-setup)
;; ;;not sure
;; (add-hook 'eglot-connect-hook #'corfu-lsp-setup)

;;from https://github.com/minad/corfu/wiki
;; Option 1: Specify explicitly to use Orderless for Eglot
(setq completion-category-overrides '((eglot (styles orderless))))

;; Option 2: Undo the Eglot modification of completion-category-defaults
(with-eval-after-load 'eglot
  (setq completion-category-defaults nil))
(defun lsp-mode-setup-corfu-completion ()
  "Set up lsp-mode to work with Corfu.

This should be called in the hook for lsp-mode (tipically `lsp-completion-mode-hook'.
Taken from https://github.com/minad/corfu/wiki ."
  (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
	'(orderless)))
(add-hook 'lsp-completion-mode-hook #'lsp-mode-setup-corfu-completion)

(setq corfu-auto-prefix 1)
(setq corfu-auto-delay 0.5)
;; Enable auto completion and configure quitting
(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t

;; my version
;; (defun corfu-custom-complete ()
;;   "Complete common part of candidates, without exiting completion."
;;   (interactive)
;;   (let* (
;; 	 (current-symbol (thing-at-point 'symbol :no-properties))
;; 	 (bounds (bounds-of-thing-at-point 'symbol))
;; 	 (start (car bounds))
;; 	 (end (cdr bounds))
;; 	 (common-part (try-completion current-symbol corfu--candidates)))
;;     (if (and (not (cdr corfu--candidates))
;;              (equal common-part (car corfu--candidates)))
;;         (corfu-insert)
;;       (progn
;;       (delete-region start end)
;;       (insert common-part)))))

;; (define-key corfu-map (kbd "TAB") #'corfu-custom-complete)
;; (define-key corfu-map (kbd "<tab>") #'corfu-custom-complete)

;; suggested on GH
(defun corfu-complete-common-or-next ()
  "Complete common prefix or go to next candidate."
  (interactive)
  (if (= corfu--total 1)
      (progn
        (corfu--goto 1)
        (corfu-insert))
    (let* ((str (car corfu--input))
           (pt (cdr corfu--input))
           (common (try-completion str corfu--candidates)))
      (if (and (stringp common)
               (not (string= str common)))
          (insert (substring common pt))
	;; uncomment this line if you want <tab> to cycle between completion candidates
        ;; (corfu-next)
	))))
(put 'corfu-complete-common-or-next 'completion-predicate #'ignore)
(define-key corfu-map (kbd "<tab>") #'corfu-complete-common-or-next)
;; Corfu-doc --------------
;; (require 'corfu-doc)
;; (add-hook 'corfu-mode-hook #'corfu-doc-mode)
;; (define-key corfu-map (kbd "M-d") #'corfu-doc-toggle)
;; (define-key corfu-map (kbd "M-p") #'corfu-doc-scroll-up)
;; (define-key corfu-map (kbd "M-n") #'corfu-doc-scroll-down)
;;---------------
;; CIDER
;;---------------
(add-hook 'clojure-mode-hook #'cider-mode)

;;----------------
;; PlantUML
;;----------------
;; (defun get-string-from-file (filePath)
;;   "Return file FILEPATH, putting content in a string."
;;   (with-temp-buffer
;;     (insert-file-contents filePath)
;;     (buffer-string)))
;; from http://xahlee.info/emacs/emacs/elisp_read_file_content.html
;; thanks to ???Pascal J Bourguignon??? and ???TheFlyingDutchman [zzbba???@aol.com]???. 2010-09-02

(require 'plantuml-mode)
(require 'flycheck-plantuml)
(add-to-list 'auto-mode-alist '("\\.uml\\'" . plantuml-mode))

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

;;----------------
;; Projectile
;;-------------
(require 'projectile)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)
;;---------------
;;Ggtags
;;--------------
;; (require 'ggtags)
;; (defun my/ggtags-activate ()
;;   "Activate ggtags.

;; If there exist a corresponding GTAGS file, activate `ggtags-mode'. Otherwise, stick to nothing (or, usually, xref)"
;;   (progn
;;     (if (ggtags-find-project)
;; 	(ggtags-mode)
;;       nil)
;;     )
;;   )

;; (define-key ggtags-mode-map (kbd "C-c M-g") nil)
;; (define-key ggtags-navigation-map (kbd "M-o") #'ace-window)

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode
;; 				  ;;'c++-mode ;;as the xref/lsp one is better
;; 				  'java-mode)
;;               (my/ggtags-activate))))

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

;; Reftex -------------

(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

(define-key reftex-mode-map (kbd "M-.") #'reftex-view-crossref)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-idle-time 1.0)
;;taken from https://tex.stackexchange.com/questions/54739/reftex-wont-find-my-bib-file-in-local-library-tree
;; So that RefTeX finds my bibliography
(setq reftex-default-bibliography '("~/Library/Library.bib"))
;; So that RefTeX also recognizes \addbibresource. Note that you
;; can't use $HOME in path for \addbibresource but that "~"
;; works.
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

;; ;; Company-reftex
;; (push 'company-reftex-citations company-backends)
;; (push 'company-reftex-labels company-backends)
;; (add-hook 'reftex-mode-hook #'company-mode)
;;-----------------
;; Muse
;;--------------
;;(add-hook 'muse-mode-hook 'toggle-word-wrap)
(add-hook 'muse-mode-hook 'visual-line-mode)
;;--------------
;; Org
;;------------
(require 'org)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'abbrev-mode)
(setf org-highlight-links '(bracket plain radio tag date footnote))

(require 'org-capture)
(setq org-capture-templates
 '(("c" "Comment" entry (file+headline "~/.notes" "Comments")
    "** Comment %t\n From: %a\n \"%i\"\n\n %?\n\n")
   ("f" "Fantasy Chronicles" entry (file+headline "~/FantasyChronicles/notes.org" "Note rapide")
    "** Capture %t\n  Da: %a\n  \"%i\"\n\n  %?\n\n")
   ("n" "Note" entry (file+headline "~/.notes" "Notes")
    "** Note %t\n  %?\n\n")
   ("N" "Titled note" entry (file+headline "~/.notes" "Notes")
    "** %? %t\n  \n")
   ("l" "LLVM journal" entry
    (file+datetree "~/tesi/llvm_journal.org")
    "* %<%H:%M> %?\n\n" :empty-lines 1)
   ("m" "Middleware journal" entry
    (file+datetree "~/middleware/middleware_projectA/mid_journal.org")
    "* %<%H:%M> %?\n\n" :empty-lines 1)
   ("t" "Task" entry (file+headline "~/.notes" "Tasks")
    "* TODO %?\n  %i\n  %a")
   ("a" "Agenda task" entry (file+headline "~/agenda.org" "Agenda tasks")
    "* TODO %?\n  %i\n  %a")))

(define-key org-mode-map (kbd "C-M-e") 'org-emphasize)
(setq org-use-sub-superscripts '{})
(setq org-export-with-sub-superscripts '{})

(defun electric-insert-left-angle-bracket ()
  "Insert a left angle bracket ('<') and, if doubles, convert it to an open guillemet ('??')."
  (interactive)
  (if (equal (char-before (point)) #x3c);;code for <
      (progn
	(delete-char -1) ;;TODO see doc
	(insert-char #x00ab 1 t)) ;;code for ??
    (insert-char #x3c 1 t))
  )

(defun electric-insert-right-angle-bracket ()
  "Insert a right angle bracket ('>') and, if double, convert it to a close guillemet ('??')."
  (interactive)
  (if (equal (char-before (point)) #x3e);;code for >
      (progn
	(delete-char -1) ;;TODO see doc
	(insert-char #x00bb 1 t)) ;;code for ??
    (insert-char #x3e 1 t))
  )

(defun quoted-insert-left-angle-bracket ()
  "Insert the quoted char '<'."
  (interactive)
  (progn (insert-char #x3c 1 t)))

(defun quoted-insert-right-angle-bracket ()
  "Insert the quoted char '>'."
  (interactive)
  (progn (insert-char #x3e 1 t)))

(define-minor-mode narrative-mode
  "A minor mode that overrides the angle brackets insertion, changing them to guillemets.

Binds '<' and '>' to specific functions, which converts \"<<\" to '??' and \">>\" to '??'. Normal angle brackets can be inserted with C-< and C->."
  :lighter " narr"
  :keymap `(((kbd "<") . electric-insert-left-angle-bracket)
	    ((kbd ">") . electric-insert-right-angle-bracket)
	    (,(kbd "C-<") . quoted-insert-left-angle-bracket)
	    (,(kbd "C->") . quoted-insert-right-angle-bracket)
	    )
  )

;;normally, C-< and C-> insert guillemets
(global-set-key (kbd "C-<") #'electric-insert-left-angle-bracket)
(global-set-key (kbd "C->") #'electric-insert-right-angle-bracket)

;;timer
(setq org-clock-sound "/home/alessandro/.emacs.d/AC_Bicycle-bell-1.au")
;;(setq org-clock-sound "~/.emacs.d/modded.wav")
;; taken from https://commons.wikimedia.org/wiki/File:Bicycle-bell-1.wav
;; and converted using an online converter
(global-set-key (kbd "C-c C-x ;") #'org-timer-set-timer)
(global-set-key (kbd "C-c C-x ,") #'org-timer-pause-or-continue)
(global-set-key (kbd "C-c C-x _") #'org-timer-stop)
;; these keybindings are suggested by the org guide
;;(global-set-key (kbd "C-c l") #'org-store-link) ;; it conflicts with lsp-mode
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Citar ----------------
(require 'citar)
;; (require 'oc-citar)
(require 'ivy-bibtex)
(autoload 'ivy-bibtex "ivy-bibtex" "" t)
(setq bibtex-completion-bibliography
      '("~/Library/Library.bib"))
(setq ivy-re-builders-alist
      '((ivy-bibtex . ivy--regex-ignore-order)
        (t . ivy--regex-plus)))
;; (defun ivy-bibtex-my-publications (&optional arg)
;;   "Search BibTeX entries authored by ???Jane Doe???.

;; With a prefix ARG, the cache is invalidated and the bibliography reread."
;;   (interactive "P")
;;   (when arg
;;     (bibtex-completion-clear-cache))
;;   (bibtex-completion-init)
;;   (ivy-read "BibTeX Items: "
;;             (bibtex-completion-candidates)
;;             :initial-input "acm"
;;             :caller 'ivy-bibtex
;;             :action ivy-bibtex-default-action))

;; ;; Bind this search function to Ctrl-x p:
;; (global-set-key (kbd "C-x p") 'ivy-bibtex-my-publications)
(require 'oc-biblatex)
(require 'oc-natbib)
(require 'ox-latex)
;; (setq org-latex-pdf-process '(
;; (setq org-latex-pdf-process '("pdflatex -output-directory %o %f"
;;                               "bibtex %b"
;;                               "pdflatex -output-directory %o %f"
;;                               "pdflatex -output-directory %o %f"))
(setq org-cite-global-bibliography '("~/Library/Library.bib"))
(setq org-cite-insert-processor 'citar
      org-cite-follow-processor 'citar
      org-cite-activate-processor 'citar
      citar-bibliography org-cite-global-bibliography)
(define-key org-mode-map (kbd "C-c b") #'org-cite-insert)
(define-key minibuffer-local-map (kbd "M-b") #'citar-insert-preset)

;;-----------------
;; YASnippet
;;-----------------
(require 'yasnippet)
(require 'license-snippets)
(yas-reload-all)
(yas-global-mode)
(license-snippets-init)


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
;; apparently, this must be done before loading in any way lsp-mode
(setq lsp-keymap-prefix "C-c l")
(define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
;; this must be called after to let which-key see the new prefix, think
(add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
(define-key lsp-mode-map (kbd "M-RET") 'lsp-execute-code-action)
;;suggested by lsp-java doc
(setq lsp-completion-enable-additional-text-edit nil)


;;copied from https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/
;;probably is better
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; (eval-after-load 'lsp-mode (setq 'lsp-modeline-code-actions-segments '(icon name)))

;;------------------
;; Programing environment
;;---------------------
;;(add-hook 'c-mode-hook #'eglot-ensure)
;;(add-hook 'c++-mode-hook #'eglot-ensure)
;;(add-hook 'java-mode-hook #'eglot-ensure)
;;(add-hook 'java-mode-hook #'lsp)
;;(add-hook 'java-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(remove-hook 'bison-mode-hook 'lsp)
(remove-hook 'flex-mode-hook 'lsp)

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
;; (add-hook 'prog-mode-hook 'company-mode)
;; (define-key prog-mode-map (kbd "C-M-i") 'company-complete)
;; (eval-after-load 'comapny '(define-key company-mode-map (kbd "<C-tab>") 'company-complete))
;; (eval-after-load 'company '(define-key company-active-map (kbd "<tab>") 'company-complete))
;; (eval-after-load 'company '(add-to-list 'company-backends 'company-capf))
;; (setq company-minimum-prefix-length 1)

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
