# Skewer Reload Stylesheet Mode

[skewer-mode](https://raw.github.com/skeeto/skewer-mode/master/README.md)
is a pure-elisp live-editing tool for web development in Emacs. It is a
glorious thing.

Alas, when maintaining a codebase with convoluted CSS cascades, skewer's
built-in CSS mode is not useful. Whenever you send a rule to the browser, it
appends it to the DOM in a <style> tag.

For many purposes, that works perfectly.

However, when several stylesheets have rules that interact closely via the
cascade, skewer-mode's approach isn't useful. What you see while live-editing
is not what you see when you refresh.

Enter this tiny minor mode.

Activate it (and skewer) while editing a CSS file, skewer the target browser
window, and `C-x C-r` will save your current stylesheet and have the browser
reload it from disk (by removing/reinserting the link tag in the same spot).

This way, you get live-editing of stylesheets that always reflects the cascade.

If you have a lot of inline CSS to deal with, start using stylesheets. You'll
be able to live-edit the stylesheets with this mode, since the inline styles
will still have their proper place in the cascade.
