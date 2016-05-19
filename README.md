# skewer-reload-stylesheets.el --- live-edit CSS stylesheets.

This is free and unencumbered software released into the public domain.

* Author: Nate Eagleson <nate@nateeag.com>
* Created: November 23, 2013
* Package-Requires: ((skewer-mode "1.5.3"))
* Version: 0.1.0

# Commentary

This minor mode provides live-editing of CSS stylesheets via skewer.
skewer-css works for many cases, but if you're dealing with multiple
stylesheets and involved cascading (a.k.a. "legacy code"), it isn't so
useful. What you see while live-editing is not what you see when you
refresh.

Enter this minor mode.

Start skewer (see its docs for how) then skewer the browser window you want
to live-edit.

Next, open a CSS file used on the skewered page, and activate this mode.
Make some edits then press `C-x C-r`. The stylesheet will be saved, and the
browser will reload it from disk, by updating the query string on the link
tag's href attribute.

and there you are - cross-browser live-editing for arbitrarily complex
stylesheets.

Key bindings:

* C-x C-r -- `skewer-reload-stylesheets-reload-buffer`


