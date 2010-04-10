;;; clevercss-mode.el --- A major mode for editing CleverCSS files

;; Author: Joe Schafer
;; Created: Apr 2010
;; Keywords: languages css

(defconst clevercss-version "0.1"
  "`clevercss-mode' version number.")

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This is a major mode for editing CleverCSS files.  Much of the
;; functionality imitates that of `python-mode'. `clevercss-mode'
;; provides support for imenu and hideshow.

;;; Installation:

;; To install, just drop this file into a directory on your load-path.
;; This mode assumes that CleverCSS files have the suffix ".pcss".
;; You may use additional suffixes by adding them to
;; `auto-mode-alist'.  For example, to add the suffix ".ccss" you
;; would write the following in your .emacs file.
;;
;; (add-to-list auto-mode-alist '("\\.ccss\\'" . clevercss-mode))

;;; Bug Reporting:

;; Patches welcome.

;;; History:

;; Apr 2010 - Created

;;; Todo:

;; Implement functionality...
;; blah

;;; Code:

(defgroup clevercss nil
  "Major mode for editing CleverCSS files in Emacs."
  :group 'languages
  :prefix "clevercss-")

(defcustom clevercss-indent 4
  "*Amout of offset per level of indentation."
  :type 'integer
  :group 'clevercss)
(put 'clevercss-indent 'safe-local-variable 'integerp)

(defcustom clevercss-guess-indent t
  "Non-nil means Clevercss mode guesses `clevercss-indent' for the buffer."
  :type 'boolean
  :group 'clevercss)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.pcss\\'" . clevercss-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ccss\\'" . clevercss-mode))

(define-derived-mode clevercss-mode fundamental-mode "Clevercss"
  "Major mode for editing Clevercss programs.
Blank lines separate paragraphs, comments start with `// '.

The indentation width is controlled by `clevercss-indent', which
defaults to 4.  If `clevercss-guess-indent' is non-nil, then try to
match the indentation of the file.

Modules can hook in via `clevercss-mode-hook'.

Use `clevercss-version' to display the current version of this
file.

\\{clevercss-mode-map} "
  :group 'clevercss
  (set (make-local-variable 'font-lock-defaults)
       '(clevercss-font-lock-keywords))
  (interactive)
  (set (make-local-variable 'parse-sexp-lookup-properties) t)
  (set (make-local-variable 'parse-sexp-ignore-comments) t)
  (set (make-local-variable 'comment-start) "// ")
  (set (make-local-variable 'indent-line-function) #'clevercss-indent-line)
  (set (make-local-variable 'indent-region-function) #'clevercss-indent-region)
  (set (make-local-variable 'paragraph-start) "\\s-*$")
  (set (make-local-variable 'fill-paragraph-function) 'clevercss-fill-paragraph)
  (set (make-local-variable 'require-final-newline) mode-require-final-newline)
  ;; FIXME
  (set (make-local-variable 'which-func-functions) '(clevercss-which-function))
  (set (make-local-variable 'add-log-current-defun-function)
       'clevercss-current-defun)

  ;; (add-to-list 'hs-special-modes-alist
  ;;              '(clevercss-mode "\\(?:procedure\\|function\\|class\\)" nil
  ;;                            "#" clevercss-end-of-block nil))
;;;   (set (make-local-variable 'hs-hide-all-non-comment-function)
;;;        'clevercss-hs-hide-level-1)
  (set (make-local-variable 'beginning-of-defun-function)
       'clevercss-beginning-of-defun)
  (set (make-local-variable 'end-of-defun-function) 'clevercss-end-of-defun)
  (add-hook 'which-func-functions 'clevercss-which-func nil t)
  (setq imenu-create-index-function #'clevercss-imenu-create-index)
  (set (make-local-variable 'ispell-check-comments) 'exclusive)
;;;   (set (make-local-variable 'eldoc-documentation-function)
;;;        #'python-eldoc-function)
  (unless font-lock-mode (font-lock-mode 1))
  (when clevercss-guess-indent (clevercss-guess-indent))
  )

;;; clevercss-mode.el ends here