======================
 CleverCSS Emacs Mode
======================

This is a major mode for editing CleverCSS files.  To use, simply
place the file in your Emacs load path.  This mode assumes that you
use either ".pcss" or ".ccss" as the file extension for CleverCSS
files.  You may add additional extensions by modifying
`auto-mode-alist`.  For example, to load CleverCSS mode on files with
the extension `foo` you would write the following in your .emacs file.

    (add-to-list auto-mode-alist '("\\.foo\\'" . clevercss-mode))

If you find bugs, patches are welcome.
