(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define (corner-buttons)
  (let ([window  (gtk-window-new 'toplevel)]
        [ okBtn  (gtk-button-new-with-label "OK")]
        [clsBtn  (gtk-button-new-with-label "Close")]
        [vbox    (gtk-vbox-new #f 0)]
        [hbox    (gtk-hbox-new #t 3)]
        [halign  (gtk-alignment-new 1 0 0 0)]
        [valign  (gtk-alignment-new 0 1 0 0)])
    (set-title        window "Corner buttons")
    (set-default-size window 350 200)
    (set-position     window 'center)
    (set-border-width window 10)

    (add vbox   valign)
    (add window vbox)

    (set-size-request okBtn 70 30)
    (add hbox okBtn)
    (add hbox clsBtn)

    (add halign hbox)

    (pack-start vbox halign #f #f 0)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(corner-buttons)
(gtk-main)
