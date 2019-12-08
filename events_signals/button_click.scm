(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define (button-clicked button)
  (display "clicked")

  (newline))

(define (click)
  (let ([window (gtk-window-new 'toplevel)]
        [halign (gtk-alignment-new 0 0 0 0)]
        [btn    (gtk-button-new-with-label "Click")])
    (set-title        window "GtkButton")
    (set-default-size window 300 200)
    (set-position     window 'center)
    (set-border-width window 15)

    (set-size-request btn 70 30)

    (add halign btn)
    (add window halign)

    (connect btn    'clicked button-clicked)
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(click)
(gtk-main)
