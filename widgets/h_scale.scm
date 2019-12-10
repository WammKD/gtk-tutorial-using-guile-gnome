(use-modules (gnome-2) (oop goops) (gnome gtk) (ice-9 format))

(define (value-changed range lbl)
  (set-text lbl (format #f "~,6f" (get-value range))))

(define (scale)
  (let ([window (gtk-window-new 'toplevel)]
        [halign (gtk-alignment-new 0 0 0 0)]
        [hbox   (gtk-hbox-new #f 20)]
        [hscale (gtk-hscale-new-with-range 0 100 1)]
        [label  (gtk-label-new "…")])
    (set-title        window "GtkHScale")
    (set-default-size window 300 250)
    (set-position     window 'center)
    (set-border-width window 10)

    (set-draw-value   hscale #f)
    (set-size-request hscale 150 -1)

    (set-alignment label 0.0 1)

    (pack-start hbox hscale #f #f 0)
    (pack-start hbox label  #f #f 0)

    (add halign hbox)
    (add window halign)

    (connect window 'destroy       (lambda (w) (gtk-main-quit)))
    (connect hscale 'value-changed (lambda (h) (value-changed h label)))

    (show-all window)))

(scale)
(gtk-main)
