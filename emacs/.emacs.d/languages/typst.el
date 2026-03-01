(defun org-typst-preview ()
  (interactive)
  (let (checkdir-flag)
	(org-element-map
		(org-element-parse-buffer)
		'(src-block)
	  (lambda (bl)
		(when (string= (org-element-property :language bl) "typst")
			(let* ((start (org-element-property :begin bl))
				   (value (org-element-property :value bl))
				   (end (+ start
						   (length
							(string-to-list
							 (concat "#+begin_src typst" value "#+end_src\n")))))
				   (fg (plist-get org-format-latex-options :foreground))
				   (hash (sha1 (prin1-to-string (list value fg))))
				   (imagetype "svg")
				   (prefix (concat "typstimg/" "org-typst"))
				   (absprefix (expand-file-name prefix))
				   (linkfile (format "%s_%s.%s" prefix hash imagetype))
				   (movefile (format "%s_%s.%s" absprefix hash imagetype))
				   (sep "\n\n")
				   (link (concat sep "[[file:" linkfile "]]" sep)))
		      (unless checkdir-flag ; Ensure the directory exists.
				(setq checkdir-flag t)
				(let ((todir (file-name-directory absprefix)))
				  (unless (file-directory-p todir)
					(make-directory todir t))))
			  (unless (file-exists-p movefile)
				(with-temp-buffer
				  (insert "#set text(size: 30pt, fill: rgb(\"#ebdbb2\"))\n#set page(width: auto, height: auto, margin: 10pt)\n")
				  (insert value)
				  (let* ((temp-file (make-temp-file ""))
						 (command (format
								   "typst compile %s %s" temp-file movefile)))
					(write-file temp-file)
					(shell-command command))))
			  (progn
				(dolist (o (overlays-in start end))
			      (when (eq (overlay-get o 'org-overlay-type)
							'org-latex-overlay)
					(delete-overlay o)))
				(org--make-preview-overlay start end movefile imagetype)
				(goto-char end))))))))

(provide 'org-typst-preview)
