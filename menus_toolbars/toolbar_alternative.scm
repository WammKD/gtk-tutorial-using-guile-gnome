(use-modules (gnome-2)
             (oop goops)
             (gnome gobject)
             (gnome gtk))

(define (toolbar-demo)
  (let ([window  (gtk-window-new 'toplevel)]
        ;; https://www.gnu.org/software/guile-gnome/docs/gtk/html/GtkVBox.html
                              ;homogeneous spacing
        [vbox    (gtk-vbox-new #f          0)]
        [toolbar (gtk-toolbar-new)]
        [new     (gtk-tool-button-new-from-stock (gtk-stock-id 'new))]
        [open    (gtk-tool-button-new-from-stock (gtk-stock-id 'open))]
        [save    (gtk-tool-button-new-from-stock (gtk-stock-id 'save))]
        [sep     (gtk-separator-tool-item-new)]
        [exit    (gtk-tool-button-new-from-stock (gtk-stock-id 'quit))])
    
    (set-title window "toolbar")
    (set-default-size window 250 200)
    (set-position window 'center)

    (add window vbox)

    (set-style toolbar 'icons)
    (set-border-width toolbar 2)

    (insert toolbar new -1)
    (insert toolbar open -1)
    (insert toolbar save -1)
    (insert toolbar sep -1)
    (insert toolbar exit -1)

    (pack-start vbox toolbar #f #f 5)

    (connect exit 'clicked (lambda (w) (gtk-main-quit)))
    (connect window 'destroy (lambda (w) (gtk-main-quit)))
    
    (show-all window)))

(toolbar-demo)
(gtk-main)
