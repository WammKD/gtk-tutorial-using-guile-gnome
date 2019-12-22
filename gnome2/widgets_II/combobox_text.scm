(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (combo-selected comboBox lbl)
  (set-text lbl (get-active-text comboBox)))

(define (combo)
  (let ([window (gtk-window-new 'toplevel)]
        [hbox   (gtk-hbox-new #f 0)]
        [vbox   (gtk-vbox-new #f 15)]
        [combo  (gtk-combo-box-new-text)]
        [label  (gtk-label-new "…")])
    (set-title        window "GtkComboBox")
    (set-default-size window 300 200)
    (set-position     window 'center)
    (set-border-width window 15)

    (append-text combo "Ubuntu")
    (append-text combo "Arch")
    (append-text combo "Fedora")
    (append-text combo "Mint")
    (append-text combo "Gentoo")
    (append-text combo "Debian")

    (pack-start vbox combo #f #f 0)
    (pack-start vbox label #f #f 0)
    (pack-start hbox vbox  #f #f 0)

    (add window hbox)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))
    (connect combo  'changed (lambda (c) (combo-selected c label)))

    (show-all window)))

(combo)
(gtk-main)
