(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (toggle-title checkButton win)
  (if (get-active checkButton)
      (set-title win "GtkCheckButton")
    (set-title win "")))

(define (check)
  (let ([window (gtk-window-new 'toplevel)]
        [halign (gtk-alignment-new 0 0 0 0)]
        [cb     (gtk-check-button-new-with-label "Show title")])
    (set-title        window "GtkCheckButton")
    (set-default-size window 230 150)
    (set-position     window 'center)
    (set-border-width window 15)

    (add window halign)

    (set-active cb #t)

    ;; Can't seem to find the corresponding function, in Guile…
    ;; GTK_WIDGET_UNSET_FLAGS(cb, GTK_CAN_FOCUS);

    (add halign cb)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))
    (connect cb     'clicked (lambda (c) (toggle-title c window)))

    (show-all window)))

(check)
(gtk-main)
