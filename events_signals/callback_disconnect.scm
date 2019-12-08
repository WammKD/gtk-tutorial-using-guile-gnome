(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define handlerID #f)

(define (button-clicked button)
  (display "clicked")

  (newline))

(define (toogle-signal checkedButton button)
  (if (get-active checkedButton)
      (set! handlerID (connect button 'clicked button-clicked))
    (gsignal-handler-disconnect button handlerID)))

(define (disconnect)
  (let ([window (gtk-window-new 'toplevel)]
        [hbox   (gtk-hbox-new #f 15)]
        [vbox   (gtk-vbox-new #f  5)]
        [btn    (gtk-button-new-with-label       "Click")]
        [cb     (gtk-check-button-new-with-label "Connect")])
    (set-title        window "Disconnect")
    (set-default-size window 300 200)
    (set-position     window 'center)
    (set-border-width window 15)

    (set-size-request btn 70 30)
    (pack-start hbox btn #f #f 0)

    (set-active cb #t)
    (pack-start hbox cb #f #f 0)

    (pack-start vbox hbox #f #f 0)
    (add window vbox)

    (set! handlerID (connect btn 'clicked button-clicked))
    (connect cb     'clicked (lambda (c) (toogle-signal c btn)))
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(disconnect)
(gtk-main)
