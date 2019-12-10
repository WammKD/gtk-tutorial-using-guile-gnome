(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (markup)
  (let ([window (gtk-window-new 'toplevel)]
        [label  (gtk-label-new "")])
    (set-title        window "Markup label")
    (set-default-size window 300 100)
    (set-position     window 'center)

    (set-markup label "<b>ZetCode</b>, knowledge only matters")

    (add window label)

    (show label)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show window)))

(markup)
(gtk-main)
