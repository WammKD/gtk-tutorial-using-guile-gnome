(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (button-pressed button stsBar)
  (let ([str (string-append (get-label button) " button clicked")])
    (push stsBar (get-context-id stsBar str) str)))

(define (bar)
  (let ([window    (gtk-window-new 'toplevel)]
        [hbox      (gtk-hbox-new #f 0)]
        [vbox      (gtk-vbox-new #f 0)]
        [halign    (gtk-alignment-new 0 0 0 0)]
        [balign    (gtk-alignment-new 0 1 1 0)]
        [button1   (gtk-button-new-with-label "OK")]
        [button2   (gtk-button-new-with-label "Apply")]
        [statusbar (gtk-statusbar-new)])
    (set-title        window "GtkStatusbar")
    (set-default-size window 300 200)
    (set-position     window 'center)

    (add window vbox)
    (add halign hbox)

    (pack-start vbox halign #t #t 5)

    (set-size-request button1 70 30)
    (set-size-request button2 70 30)

    (pack-start hbox button1 #f #f 5)
    (pack-start hbox button2 #f #f 0)

    (add balign statusbar)

    (pack-start vbox balign #f #f 0)

    (connect button1 'clicked (lambda (b1) (button-pressed b1 statusbar)))
    (connect button2 'clicked (lambda (b2) (button-pressed b2 statusbar)))
    (connect window  'destroy (lambda (w)  (gtk-main-quit)))

    (show-all window)))

(bar)
(gtk-main)
