(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define (alignment)
  (let ([window (gtk-window-new 'toplevel)]
        [align  (gtk-alignment-new 0 1 0 0)]
        [lbl    (gtk-label-new "bottom-left")])
    (set-title        window "GtkAlignment")
    (set-default-size window 300 200)
    (set-position     window 'center)
    (set-border-width window 5)

    (add align  lbl)
    (add window align)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(alignment)
(gtk-main)
