(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (separator)
  (let ([window     (gtk-window-new 'toplevel)]
        [label1     (gtk-label-new (string-append
                                     "Zinc is a moderately reactive, blue gray "
                                     "metal that tarnishes in moist air and "
                                     "burns in air with a bright bluish-green "
                                     "flame, giving off fumes of zinc oxide. "
                                     "It reacts with acids, alkalis and other "
                                     "non-metals. If not completely pure, zinc "
                                     "reacts with dilute acids to release "
                                     "hydrogen."))]
        [label2     (gtk-label-new (string-append
                                     "Copper is an essential trace nutrient to "
                                     "all high plants and animals. In animals, "
                                     "including humans, it is found primarily "
                                     "in the bloodstream, as a co-factor in "
                                     "various enzymes, and in copper-based "
                                     "pigments. However, in sufficient "
                                     "amounts, copper can be poisonous and "
                                     "even fatal to organisms."))]
        [hseparator (gtk-hseparator-new)]
        [vbox       (gtk-vbox-new #f 10)])
    (set-title        window "GtkHSeparator")
    (set-position     window 'center)
    (set-resizable    window #f)
    (set-border-width window 10)

    (set-line-wrap label1 #t)
    (set-line-wrap label2 #t)

    (add window vbox)

    (pack-start vbox label1     #f #t 0)
    (pack-start vbox hseparator #f #t 10)
    (pack-start vbox label2     #f #t 0)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(separator)
(gtk-main)
