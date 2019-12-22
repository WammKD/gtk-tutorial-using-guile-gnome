(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (button)
  (let ([window (gtk-window-new 'toplevel)]
        [halign (gtk-alignment-new 0 0 0 0)]
        [btn    (gtk-button-new-with-label "Quit")])
    (set-title        window "GtkButton")
    (set-default-size window 230 150)
    (set-position     window 'center)
    (set-border-width window 15)

    (add window halign)

    (set-size-request btn 70 30)

    (add halign btn)

    (connect btn    'clicked (lambda (b) (gtk-main-quit)))
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(button)
(gtk-main)
