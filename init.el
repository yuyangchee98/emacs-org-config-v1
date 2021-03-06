(package-initialize)

; MELPA, Package manager
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "https://melpa.org/packages/")
   t))

; Evil Mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(setq evil-default-state 'emacs)
(evil-mode 1)

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

; Require org-gcal
(require 'org-gcal)
(setq org-gcal-client-id "454851124200-8bfphu62p58ulajhmbjoihddabjnm6gi.apps.googleusercontent.com"
      org-gcal-client-secret "yK_p4IuF37e2u1BonXkzq5dY"
      org-gcal-file-alist '(("57ev72kpvi65gt5nl0ool794jc@group.calendar.google.com" .  "~/Dropbox/org/calendar/personalEvents.org")
			    ("tvv34uratptn4vq7dsfrnuinfs@group.calendar.google.com" .  "~/Dropbox/org/calendar/campusJobs.org")
			    ("jci40ahfs1mpu6vt20dsr9ie7k@group.calendar.google.com" .  "~/Dropbox/org/calendar/deadlines.org")
			    ("f2fkaifin1sohrum7mtmtqcrs4@group.calendar.google.com" .  "~/Dropbox/org/calendar/scuAssignments.org")
			    ("def3amttatrluc5th821sn5sp8@group.calendar.google.com" .  "~/Dropbox/org/calendar/scuEAndM.org")
			    ("44bftb63bkgs01riiu70hf4s6s@group.calendar.google.com" .  "~/Dropbox/org/calendar/scuTimetable.org")
			    ("jci40ahfs1mpu6vt20dsr9ie7k@group.calendar.google.com" .  "~/Dropbox/org/calendar/Deadlines.org")
			    ("34h40480rtlvq4pucb700lei04@group.calendar.google.com" .  "~/Dropbox/org/calendar/importantDays.org")			    
			    ))

; Sync org and gcal everytime agenda is opened
; (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))

;Org mode
(require 'org)

; Org mode global access hotkeys
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

; Org mode indenting
(add-hook 'org-mode-hook 'org-indent-mode)

; Shift select
(setq org-support-shift-select 'always)

; Org-agenda folder setting
(setq org-agenda-files '("~/org"))

;Inserting today's date with the command 'M-x insert-today-date'
(defun insert-today-date () (interactive)
	 (insert (shell-command-to-string "echo -n $(date +%d-%m-%Y)")))

;Insert SCU folder path with the command "M-x path-home"
(defun path-scu () (interactive)
	 (insert (shell-command-to-string "echo ../../Google\ Drive/SCU/Spring\ 20/ ")))

;Insert home folder  path with the command "M-x path-home"
(defun path-home () (interactive)
	 (insert (shell-command-to-string "echo ../../ ")))

; Text wrap
(global-visual-line-mode t)

;These are automatic from MELPA package-install
;ox-twbs exports to bootstrap HTML
;flucui-themes is for theming
;org, orgalist, org-eda are all the org mode crap

; Require ox-twbs
(require 'ox-twbs)

; Fixes elpa bug
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

; Latex link in emacs
(exec-path-from-shell-initialize)

; "Hey that file change on disk; I'll reload"
(global-auto-revert-mode 1)

; Set automatically when installed.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (misterioso)))
 '(display-line-numbers nil)
 '(icomplete-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(org-agenda-files
   (quote
    ("/Users/yuyangchee/Dropbox/org" "/Users/yuyangchee/Dropbox/org/calendar")))
 '(org-agenda-show-current-time-in-grid t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-time-grid
   (quote
    ((daily weekly today)
     (800 1000 1200 1400 1600 1800 2000)
     "......" "----------------")))
 '(org-agenda-timegrid-use-ampm t)
 '(org-agenda-use-time-grid t)
 '(org-archive-default-command (quote org-archive-to-archive-sibling))
 '(org-archive-location "::* Archived Tasks")
 '(org-babel-load-languages (quote ((emacs-lisp . t) (C . t))))
 '(org-capture-templates
   (quote
    (("d" "Start day" entry
      (file+olp+datetree "~/Dropbox/org/personal.org" "Personal" "Daily")
      "* Day planning [/]
Morning
- [ ] %^{Task 1}
- [ ] %^{Task 2}
- [ ] %^{Task 3}

Afternoon
- [ ] %^{Task 4}

Night
- [ ] %^{Task 5}
- [ ] %^{Task 6}
- [ ] %^{Task 7}

Daily
- [ ] Book
- [ ] Pocket
- [ ] Journal/ Reflect

:LOGBOOK:
- Added: %T
:END:" :prepend t)
     ("i" "Ideas" entry
      (file+headline "~/Dropbox/org/personal.org" "Ideas")
      "* %^{Product/ business idea}
- Description:
%^{Description}

:Logbook:
- Added: %T
:END:")
     ("rd" "Reflect daily" entry
      (file+olp+datetree "~/Dropbox/org/personal.org" "Personal" "Daily")
      "* Daily writing ::
%^{Story}
:LOGBOOK:
- Added %T
:END:")
     ("rm" "Reflect Monthly" entry
      (file+olp+datetree "~/Dropbox/org/personal.org" "Personal" "Daily")
      "* Monthly reflection
** What got done?
%^{Story}

** Feelings
%^{Story}

** Others
%^{Story}

:LOGBOOK:
- Added %T
:END\"")
     ("rw" "Reflect weekly" entry
      (file+olp+datetree "~/Dropbox/org/personal.org" "Personal" "Daily")
      "* Weekly reflection
** What got done?
%^{Story}

** Feelings
%^{Story}

** Others
%^{Story}

:LOGBOOK:
- Added %T
:END\"")
     ("r" "Reflect"))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 1.6 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-hide-leading-stars t)
 '(org-indent-indentation-per-level 1)
 '(org-indent-mode-turns-on-hiding-stars t)
 '(org-log-into-drawer t)
 '(org-log-reschedule (quote note))
 '(org-preview-latex-default-process (quote dvipng))
 '(org-preview-latex-process-alist
   (quote
    ((dvipng :programs
	     ("latex" "dvipng")
	     :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
	     (1.0 . 1.0)
	     :latex-compiler
	     ("latex -interaction nonstopmode -output-directory %o %f")
	     :image-converter
	     ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
     (dvisvgm :programs
	      ("latex" "dvisvgm")
	      :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
	      (1.7 . 1.5)
	      :latex-compiler
	      ("latex -interaction nonstopmode -output-directory %o %f")
	      :image-converter
	      ("dvisvgm %f -n -b min -c %S -o %O"))
     (imagemagick :programs
		  ("latex" "convert")
		  :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
		  (1.0 . 1.0)
		  :latex-compiler
		  ("pdflatex -interaction nonstopmode -output-directory %o %f")
		  :image-converter
		  ("convert -density %D -trim -antialias %f -quality 100 %O")))))
 '(package-selected-packages
   (quote
    (org-gcal org-pdftools markdown-mode magit exec-path-from-shell px ac-capf latex-preview-pane auctex langtool fzf ox-twbs flucui-themes org ## orgalist org-edna)))
 '(user-full-name "Yu Yang Chee"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2d3743" :foreground "#e1e1e0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Meslo LG L DZ for Powerline"))))
 '(org-hide ((t (:foreground "brightwhite")))))
