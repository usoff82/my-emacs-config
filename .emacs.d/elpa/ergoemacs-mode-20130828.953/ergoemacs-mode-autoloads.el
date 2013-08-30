;;; ergoemacs-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ergoemacs-svgs ergoemacs-keyfreq-image ergoemacs-extras
;;;;;;  ergoemacs-bash ergoemacs-ghpages) "ergoemacs-extras" "ergoemacs-extras.el"
;;;;;;  (21023 27956 0 0))
;;; Generated autoloads from ergoemacs-extras.el

(autoload 'ergoemacs-ghpages "ergoemacs-extras" "\
Generate github pages with o-blog.

\(fn &optional ARG)" t nil)

(autoload 'ergoemacs-bash "ergoemacs-extras" "\
Generates `~/.inputrc' to use ergoemacs-keys in bash.  This is
based on ergoemacs' current theme and layout.

\(fn)" t nil)

(autoload 'ergoemacs-extras "ergoemacs-extras" "\
Generate layout diagram, and other scripts for system-wide ErgoEmacs keybinding.

The following are generated:
• SVG Diagram for ErgoEmacs command layouts in SVG format.
• Bash 〔.inputrc〕 code.
• Mac OS X 〔DefaultKeyBinding.dict〕 code.
• AutoHotkey script for Microsoft Windows.

Files are generated in the dir 〔ergoemacs-extras〕 at `user-emacs-directory'.

\(fn &optional LAYOUTS)" t nil)

(autoload 'ergoemacs-keyfreq-image "ergoemacs-extras" "\
Create heatmap keyfreq images, based on the current layout.

\(fn)" t nil)

(autoload 'ergoemacs-svgs "ergoemacs-extras" "\
Generate SVGs for all the defined layouts and themes.

\(fn &optional LAYOUTS)" t nil)

;;;***

;;;### (autoloads (ergoemacs-unaccent-char ergoemacs-unaccent-region
;;;;;;  ergoemacs-unaccent-word) "ergoemacs-functions" "ergoemacs-functions.el"
;;;;;;  (21023 27955 0 0))
;;; Generated autoloads from ergoemacs-functions.el

(autoload 'ergoemacs-unaccent-word "ergoemacs-functions" "\
Move curseur forward NUM (prefix arg) words, removing accents.
Guillemet -> quote, degree -> @, s-zed -> ss, upside-down ?! -> ?!.

\(fn NUM)" t nil)

(autoload 'ergoemacs-unaccent-region "ergoemacs-functions" "\
Replace accented chars between START and END by unaccented chars.
Guillemet -> quote, degree -> @, s-zed -> ss, upside-down ?! -> ?!.
When called from a program, third arg DISPLAY-MSGS non-nil means to
display in-progress messages.

\(fn START END DISPLAY-MSGS)" t nil)

(autoload 'ergoemacs-unaccent-char "ergoemacs-functions" "\
Replace accented char at curser by corresponding unaccented char(s).
Guillemet -> quote, degree -> @, s-zed -> ss, upside-down ?! -> ?!.

\(fn)" t nil)

;;;***

;;;### (autoloads (ergoemacs-mode ergoemacs-keyboard-shortcut) "ergoemacs-mode"
;;;;;;  "ergoemacs-mode.el" (21023 27955 0 0))
;;; Generated autoloads from ergoemacs-mode.el

(autoload 'ergoemacs-keyboard-shortcut "ergoemacs-mode" "\
Creates a function NAME that issues a keyboard shortcut for KEY.
CHORDED is a variable that alters to keymap to allow unchorded
key sequences.

If CHORDED is nil, the NAME command will just issue the KEY sequence.

If CHORDED is 'ctl or the NAME command will translate the control
bindings to be unchorded.  For example:

For example for the C-x map,

Original Key   Translated Key  Function
C-k C-n     -> k n             (kmacro-cycle-ring-next)
C-k a       -> k M-a           (kmacro-add-counter)
C-k M-a     -> k C-a           not defined
C-k S-a     -> k S-a           not defined

If CHORDED is 'ctl-to-alt or the NAME command will translate the control
bindings to be unchorded.  For example:

C-k C-n     -> M-k M-n             (kmacro-cycle-ring-next)
C-k a       -> M-k a           (kmacro-add-counter)
C-k M-a     -> k C-a           not defined
C-k S-a     -> k S-a           not defined

When REPEAT is a variable name, then an easy repeat is setup for the command.

For example if you bind <apps> m to Ctrl+c Ctrl+c, this allows Ctrl+c Ctrl+c to be repeated by m.

\(fn NAME KEY &optional CHORDED REPEAT)" nil t)

(defvar ergoemacs-mode nil "\
Non-nil if Ergoemacs mode is enabled.
See the command `ergoemacs-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ergoemacs-mode'.")

(custom-autoload 'ergoemacs-mode "ergoemacs-mode" nil)

(autoload 'ergoemacs-mode "ergoemacs-mode" "\
Toggle ergoemacs keybinding minor mode.
This minor mode changes your emacs keybinding.

Without argument, toggles the minor mode.
If optional argument is 1, turn it on.
If optional argument is 0, turn it off.

Home page URL `http://ergoemacs.github.io/ergoemacs-mode/'

For the standard layout, with A QWERTY keyboard the `execute-extended-command' M-x is now M-a.

The layout and theme changes the bindings.  For the current
bindings the keymap is:

\\{ergoemacs-keymap}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (ergoemacs-test) "ergoemacs-test" "ergoemacs-test.el"
;;;;;;  (21023 27956 0 0))
;;; Generated autoloads from ergoemacs-test.el

(autoload 'ergoemacs-test "ergoemacs-test" "\
Test ergoemacs issues.

\(fn)" t nil)

;;;***

;;;### (autoloads (ergoemacs-minor-key ergoemacs-replace-key ergoemacs-fixed-key
;;;;;;  ergoemacs-key) "ergoemacs-themes" "ergoemacs-themes.el" (21023
;;;;;;  27955 0 0))
;;; Generated autoloads from ergoemacs-themes.el

(autoload 'ergoemacs-key "ergoemacs-themes" "\
Defines KEY in ergoemacs keyboard based on QWERTY and binds to FUNCTION.
Optionally provides DESC for a description of the key.

\(fn KEY FUNCTION &optional DESC ONLY-FIRST FIXED-KEY)" nil nil)

(autoload 'ergoemacs-fixed-key "ergoemacs-themes" "\
Defines KEY that calls FUNCTION in ergoemacs keyboard that is the same regardless of the keyboard layout.
This optionally provides the description, DESC, too.

\(fn KEY FUNCTION &optional DESC)" nil nil)

(autoload 'ergoemacs-replace-key "ergoemacs-themes" "\
Replaces already defined FUNCTION in ergoemacs key binding with KEY.  The KEY definition is based on QWERTY description of a key

\(fn FUNCTION KEY &optional DESC ONLY-FIRST)" nil nil)

(autoload 'ergoemacs-minor-key "ergoemacs-themes" "\
Defines keys to add to an ergoemacs keyboard hook.

Adds to the list `ergoemacs-get-minor-mode-layout' by modifying the
ergoemacs hook applied to HOOK.  The LIST is of the following
format:

 (FUNCTION/KEY FUNCTION-TO-CALL KEYMAP)

\(fn HOOK LIST)" nil nil)

;;;***

;;;### (autoloads (ergoemacs-ignore-prev-global) "ergoemacs-unbind"
;;;;;;  "ergoemacs-unbind.el" (21023 27956 0 0))
;;; Generated autoloads from ergoemacs-unbind.el

(autoload 'ergoemacs-ignore-prev-global "ergoemacs-unbind" "\
Ignores previously defined global keys.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ergoemacs-advices.el" "ergoemacs-layouts.el"
;;;;;;  "ergoemacs-menus.el" "ergoemacs-mode-pkg.el" "ergoemacs-track.el")
;;;;;;  (21023 27956 685000 0))

;;;***

(provide 'ergoemacs-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ergoemacs-mode-autoloads.el ends here
