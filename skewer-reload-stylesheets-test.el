;;; skewer-reload-stylesheets-test.el --- Test package interactively

;;; Author: Nate Eagleson

;;; Version: 0.0.1

;;; Commentary:

;; This is just a quick hack to make it easier to play with the package
;; interactively in a clean Emacs instance, without having to jump through hoops.
;;
;; Ideally I'd have an actual test suite, but this is a place to start.

;;; Code:

(require 'scss-mode)

(defvar skewer-reload-stylesheets-test-file load-file-name)

(defvar skewer-reload-stylesheets-project-dir (file-name-directory
                                               load-file-name))

(defun skewer-reload-stylesheets-log-event-handler (item)
  "Respond to httpd-log events so we can verify things are working."

  (let* ((test-css-file (concat skewer-reload-stylesheets-project-dir
                                "/test/overrides.css")))
    (with-current-buffer (switch-to-buffer "*httpd*")
      (goto-char (point-max))


      (message "The item is %S" item)

      ;; FIXME This test is stupid and prone to breakage. Checking the item
      ;; itself is what I should do the but I have to figure out how.
      (if (equal (thing-at-point 'line t)
                 "(file \"/Users/nate/skewer-reload-stylesheet/test/overrides.css\")")
          (message "THE TEST PASSES!!!")
        (message "THE TEST FAILS!!!")))))

(defun skewer-reload-stylesheets-test-setup ()
  "Set up as much of the skewer infrastructure as we can."
  (setq debug-on-error t)

  ;; Arbitrarily chosen port, in hopes it's unlikely to conflict with anything
  ;; running on the average dev's machine.
  (setq httpd-root (concat skewer-reload-stylesheets-project-dir "/test"))
  (setq httpd-port 9371)

  (add-hook 'css-mode-hook
            'skewer-reload-stylesheets-start-editing)

  (let* ((test-html-url (concat (format "http://localhost:%d" httpd-port)
                                "/css-reloading.html"))
         (test-css-file (concat skewer-reload-stylesheets-project-dir
                                "/test/overrides.css")))

    (find-file test-css-file)

    ;; FIXME My current approach has this racing with my test. I somehow have
    ;; to wait to kick the test off and I'm not sure how.
    (browse-url test-html-url)))

(defun skewer-reload-stylesheets-test-one ()
  "A quick hack job to see if I have a feasible plan for testing."

  ;; Hacking around the race just to see if the basic parts are working
  (sit-for 1)

  (advice-add 'httpd-log :after #'skewer-reload-stylesheets-log-event-handler)

  (let* ((test-css-file (concat skewer-reload-stylesheets-project-dir
                                "/test/overrides.css")))
    (find-file test-css-file)

    (replace-string "red" "yellow")

    (save-buffer)

    ;; ...ah. The difficulty is now actually "how do I get httpd to tell me
    ;; when a new request comes in?"
    ;;
    ;; I should have known it couldn't be as simple as I thought it was.
    ;;
    ;; ...okay, think I got it. Advise httpd-log to run a trigger function of
    ;; my choice it httpd-log runs.
    ;;
    ;; Then each test can register a callback for the advice, trigger the
    ;; request it wants to listen for, and be done. The callback, when hit,
    ;; will set the test to a 'passing' state.
    ;;
    ;; ...yuck. Maybe this won't work after all. You of course get multiple
    ;; inbound requests, and you need to somehow track them all - to know you
    ;; don't load any you shouldn't, and only load ones you should.
    ;;
    ;; Perhaps to do this I should write a custom servlet, rather than hooking
    ;; into the log function? Advising httpd-log was definitely a hacky idea...

    ))

(provide 'skewer-reload-stylesheets-test)
;;; skewer-reload-stylesheets-test.el ends here
