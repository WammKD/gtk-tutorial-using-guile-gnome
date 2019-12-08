(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define COUNT 2)

(define (undo-redo widget item)
  (define name (get-name widget))

  (if (string=? name "undo")
      (set! COUNT (1+ COUNT))
    (set! COUNT (1- COUNT)))

  (when (< COUNT 0)
    (set-sensitive widget #f)
    (set-sensitive item   #t))

  (when (> COUNT 5)
    (set-sensitive widget #f)
    (set-sensitive item   #t)))

(define (undo-redo-main)
  (let ([window  (gtk-window-new 'toplevel)]
        [vbox    (gtk-vbox-new #f 0)]
        [toolbar (gtk-toolbar-new)]
        [undo    (gtk-tool-button-new-from-stock (gtk-stock-id 'undo))]
        [redo    (gtk-tool-button-new-from-stock (gtk-stock-id 'redo))]
        [sep     (gtk-separator-tool-item-new)]
        [exit    (gtk-tool-button-new-from-stock (gtk-stock-id 'quit))])
    (set-title window "Undo redo")
    (set-default-size window 250 200)
    (set-position window 'center)

    (add window vbox)

    (set-style toolbar 'icons)
    (set-border-width toolbar 2)

    (set-name undo "undo")
    (insert toolbar undo -1)
    (insert toolbar redo -1)
    (insert toolbar sep  -1)
    (insert toolbar exit -1)

    (pack-start vbox toolbar #f #f 0)

    (connect undo   'clicked (lambda (u) (undo-redo u redo)))
    (connect redo   'clicked (lambda (r) (undo-redo r undo)))
    (connect exit   'clicked (lambda (e) (gtk-main-quit)))
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(undo-redo-main)
(gtk-main)
