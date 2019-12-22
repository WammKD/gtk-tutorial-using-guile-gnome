(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (image)
  (let ([window (gtk-window-new 'toplevel)]
        [image  (gtk-image-new-from-file "redrock.jpg")])
    (set-title    window "Red Rock")
    (set-position window 'center)

    (add window image)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(image)
(gtk-main)
