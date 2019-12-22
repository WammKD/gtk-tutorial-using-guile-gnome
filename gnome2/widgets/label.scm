(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (label)
  (let ([window (gtk-window-new 'toplevel)]
        [label  (gtk-label-new  (string-join
                                  '("I've always been too lame"
                                    "To see what's before me"
                                    "And I know nothing sweeter than"
                                    "Champaign from last New Years"
                                    "Sweet music in my ears"
                                    "And a night full of no fears"
                                    ""
                                    "But if I had one with fulfilled tonight"
                                    "I'd ask for the sun to never rise"
                                    "If God passed a mic to me to speak"
                                    "I'd say \"Stay in bed, world,"
                                    "Sleep in peace")
                                  "\n"))])
    (set-title        window "No sleep")
    (set-position     window 'center)
    (set-border-width window 15)

    (set-justify label 'center)

    (add window label)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(label)
(gtk-main)
