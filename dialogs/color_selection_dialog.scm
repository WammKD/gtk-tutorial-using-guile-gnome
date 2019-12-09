(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define (select-font fontBtn lbl)
  (define dialog (gtk-color-selection-dialog-new "Font Color"))
  (define result (run dialog))

  (when (= result (genum->value (make <gtk-response-type> #:value 'ok)))
    (modify-fg
      lbl
      (make <gtk-state-type> #:value 'normal)
      (get (get dialog 'color-selection) 'current-color)))

  (destroy dialog))

(define (color)
  (let ([window  (gtk-window-new 'toplevel)]
        [label   (gtk-label-new "ZetCode")]
        [vbox    (gtk-vbox-new #f 0)]
        [toolbar (gtk-toolbar-new)]
        [font    (gtk-tool-button-new-from-stock (gtk-stock-id 'select-color))])
    (set-title        window "Color Selection Dialog")
    (set-default-size window 280 200)
    (set-position     window 'center)

    (add window vbox)

    (set-style        toolbar 'icons)
    (set-border-width toolbar 2)
    (insert           toolbar font -1)

    (set-justify label 'center)

    (pack-start vbox toolbar #f #f 5)
    (pack-start vbox label   #t #f 5)

    (connect font   'clicked (lambda (f) (select-font f label)))
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(color)
(gtk-main)
