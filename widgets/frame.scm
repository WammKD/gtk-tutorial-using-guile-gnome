(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (frame)
  (let ([window (gtk-window-new 'toplevel)]
        [table  (gtk-table-new 2 2 #t)]
        [frame1 (gtk-frame-new "Shadow In")]
        [frame2 (gtk-frame-new "Shadow Out")]
        [frame3 (gtk-frame-new "Shadow Etched In")]
        [frame4 (gtk-frame-new "Shadow Etched Out")])
    (set-title        window "GtkFrame")
    (set-default-size window 250 250)
    (set-position     window 'center)
    (set-border-width window 10)

    (set-row-spacings table 10)
    (set-col-spacings table 10)

    (add window table)

    (set-shadow-type frame1 (make <gtk-shadow-type> #:value 'in))
    (set-shadow-type frame2 (make <gtk-shadow-type> #:value 'out))
    (set-shadow-type frame3 (make <gtk-shadow-type> #:value 'etched-in))
    (set-shadow-type frame4 (make <gtk-shadow-type> #:value 'etched-out))

    (attach-defaults table frame1 0 1 0 1)
    (attach-defaults table frame2 0 1 1 2)
    (attach-defaults table frame3 1 2 0 1)
    (attach-defaults table frame4 1 2 1 2)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(frame)
(gtk-main)
