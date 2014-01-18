# Skewer Reload Stylesheets Mode

[skewer-mode](https://raw.github.com/skeeto/skewer-mode/master/README.md)
is a pure-elisp live-editing tool for web development in Emacs. It is a
glorious thing.

Alas, when maintaining a codebase with convoluted cascades, skewer's built-in
CSS mode is not useful. It sends rules to the browser by appending them to the
DOM in a &lt;style&gt; tag.

When several stylesheets have rules that interact closely via the cascade,
skewer-mode's approach isn't useful. What you see while live-editing is not
what you see when you refresh.

Enter this tiny minor mode.

Start skewer (see its docs for how) then skewer the browser window you want to
live-edit.

Activate this minor mode while editing a CSS file used on the displayed page,
and `C-x C-r` will save your current stylesheet and have the browser reload it
from disk (by removing/reinserting the link tag in the same spot).
