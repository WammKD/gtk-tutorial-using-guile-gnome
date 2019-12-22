(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk) (gnome gw pango))

(define (select-font fontBtn lbl)
  (define dialog (gtk-font-selection-dialog-new "Select Font"))
  (define result (run dialog))

  (when (or
          (= result (genum->value (make <gtk-response-type> #:value 'ok)))
          (= result (genum->value (make <gtk-response-type> #:value 'apply))))
    (modify-font
      lbl
      (pango-font-description-from-string (get-font-name dialog))))

  (destroy dialog))

(define (font)
  (let ([window  (gtk-window-new 'toplevel)]
        [label   (gtk-label-new "ZetCode")]
        [vbox    (gtk-vbox-new #f 0)]
        [toolbar (gtk-toolbar-new)]
        [font    (gtk-tool-button-new-from-stock (gtk-stock-id 'select-font))])
    (set-title        window "Font Selection Dialog")
    (set-default-size window 280 200)
    (set-position     window 'center)

    (add window vbox)

    (set-style        toolbar 'icons)
    (set-border-width toolbar 2)

    (insert toolbar font -1)
    (pack-start vbox toolbar #f #f 5)

    (set-justify label 'center)
    (pack-start vbox label   #t #f 5)

    (connect font   'clicked (lambda (f) (select-font f label)))
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(font)
(gtk-main)
