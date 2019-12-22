(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (enter-button button)
  (display "Ya hovered!")
  (newline)

  (modify-bg
    button
    (make <gtk-state-type> #:value 'prelight)
    #(0 27000 30000 35000)))

(define (enter)
  (let ([window (gtk-window-new 'toplevel)]
        [halign (gtk-alignment-new 0 0 0 0)]
        [btn    (gtk-button-new-with-label "Button")])
    (set-title        window "Enter signal")
    (set-default-size window 300 200)
    (set-position     window 'center)
    (set-border-width window 15)

    (set-size-request btn 70 30)

    (add halign btn)
    (add window halign)

    (connect btn    'enter   enter-button)
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(enter)
(gtk-main)
