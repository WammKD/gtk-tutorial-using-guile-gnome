(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define enum '((col-display-name . 0) (col-pixbuf . 1) (num-cols . 2)))

(define (init-model)
  (define p1        (gdk-pixbuf-new-from-file "ubuntu.png"))
  (define p2        (gdk-pixbuf-new-from-file "gnumeric.png"))
  (define p3        (gdk-pixbuf-new-from-file "blender.png"))
  (define p4        (gdk-pixbuf-new-from-file "inkscape.png"))
  (define listStore (gtk-list-store-new (list <gchararray> <gdk-pixbuf>)))

  (let ([iter1 (gtk-list-store-append listStore)])
    (gtk-list-store-set-value listStore                          iter1
                              (assoc-ref enum 'col-display-name) "Ubuntu")

    (gtk-list-store-set-value listStore iter1 (assoc-ref enum 'col-pixbuf) p1))

  (let ([iter2 (gtk-list-store-append listStore)])
    (gtk-list-store-set-value
      listStore                          iter2
      (assoc-ref enum 'col-display-name) "Gnumeric")

    (gtk-list-store-set-value listStore iter2 (assoc-ref enum 'col-pixbuf) p2))

  (let ([iter3 (gtk-list-store-append listStore)])
    (gtk-list-store-set-value
      listStore                          iter3
      (assoc-ref enum 'col-display-name) "Blender")

    (gtk-list-store-set-value listStore iter3 (assoc-ref enum 'col-pixbuf) p3))

  (let ([iter4 (gtk-list-store-append listStore)])
    (gtk-list-store-set-value
      listStore                          iter4
      (assoc-ref enum 'col-display-name) "Inkscape")

    (gtk-list-store-set-value listStore iter4 (assoc-ref enum 'col-pixbuf) p4))

  listStore)

(define (icon-view)
  (let ([window   (gtk-window-new 'toplevel)]
        [iconView (gtk-icon-view-new-with-model (init-model))]
        [sw       (gtk-scrolled-window-new)])
    (set-title        window "IconView")
    (set-default-size window 350 300)
    (set-position     window 'center)
    (set-border-width window 10)

    (add window sw)
    (set-policy
      sw
      (make <gtk-policy-type> #:value 'automatic)
      (make <gtk-policy-type> #:value 'automatic))
    (set-shadow-type sw (make <gtk-shadow-type> #:value 'in))

    (add sw iconView)

    (set-text-column    iconView (assoc-ref enum 'col-display-name))
    (set-pixbuf-column  iconView (assoc-ref enum 'col-pixbuf))
    (set-selection-mode iconView (make <gtk-selection-mode> #:value 'multiple))

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(icon-view)
(gtk-main)
