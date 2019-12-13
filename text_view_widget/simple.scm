(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk) (gnome gw pango))

(define (simple)
  (let* ([window (gtk-window-new 'toplevel)]
         [view   (gtk-text-view-new-with-buffer)]
         [vbox   (gtk-vbox-new #f 0)]
         [buffer (get-buffer view)])
    (set-position     window 'center)
    (set-default-size window 300 200)
    (set-title        window "GtkTextView")

    (pack-start vbox view #t #t 0)

    (create-tag buffer "gap"     'pixels-above-lines                 30)
    (create-tag buffer "lmarg"   'left-margin                         5)
    (create-tag buffer "blue_fg" 'foreground                     "blue")
    (create-tag buffer "gray_bg" 'background                     "gray")
    (create-tag buffer "italic"  'style              (genum->value
                                                       (make <pango-style>
                                                         #:value 'italic)))
    (create-tag buffer "bold"    'weight             (genum->value
                                                       (make <pango-weight>
                                                         #:value   'bold)))

    (let ([iter (get-iter-at-offset buffer 0)])
      (insert                   buffer iter "Plain text\n")
      (insert-with-tags-by-name buffer iter "Colored Text\n"                 '("bold"   "lmarg"))
      (insert-with-tags-by-name buffer iter "Text with colored background\n" '("lmarg"  "gray_bg"))
      (insert-with-tags-by-name buffer iter "Text in italics\n"              '("italic" "lmarg"))
      (insert-with-tags-by-name buffer iter "Bold text\n"                    '("bold"   "lmarg")))

    (add window vbox)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(simple)
(gtk-main)
