(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

;https://developer.gimp.org/api/2.0/gtk/gtk-Standard-Enumerations.html#GtkAttachOptions
(define GTK_EXPAND (ash 1 0))
(define GTK_SHRINK (ash 1 1))
(define GTK_FILL   (ash 1 2))

(define (windows)
  (let ([window  (gtk-window-new 'toplevel)]
                              ;n-rows ;n-columns ;homogeneous
        [table   (gtk-table-new 6       4          #f)]
        [title   (gtk-label-new "Windows")]
        [wins    (gtk-text-view-new-with-buffer)]
        [halign  (gtk-alignment-new 0 0 0 0)]
        [halign2 (gtk-alignment-new 0 1 0 0)]
        [valign  (gtk-alignment-new 0 0 0 0)]
        [actBtn  (gtk-button-new-with-label "Activate")]
        [clsBtn  (gtk-button-new-with-label "Close")]
        [hlpBtn  (gtk-button-new-with-label "Help")]
        [ okBtn  (gtk-button-new-with-label "OK")])
    (set-title        window "Windows")
    (set-default-size window 300 250)
    (set-position     window 'center)
    (set-border-width window 15)

    (set-col-spacings           table 3)
    (gtk-table-set-row-spacings table 0 3)

    (add halign title)
    (attach table halign  0 1 0 1 GTK_FILL      GTK_FILL      0 0)

    (set-editable       wins #f)
    (set-cursor-visible wins #f)
    (attach table wins    0 2 1 3 (logior
                                    GTK_FILL
                                    GTK_EXPAND) (logior
                                                  GTK_FILL
                                                  GTK_EXPAND) 1 1)

    (set-size-request actBtn 50 30)
    (attach table actBtn  3 4 1 2 GTK_FILL      GTK_SHRINK    0 0)

    (set-size-request clsBtn 70 30)
    (add valign clsBtn)

    (gtk-table-set-row-spacings table 1 3)
    (attach table valign  3 4 2 3 GTK_FILL      (logior
                                                  GTK_FILL
                                                  GTK_EXPAND) 1 1)

    (add halign2 hlpBtn)
    (set-size-request hlpBtn 70 30)

    (gtk-table-set-row-spacings table 3 5)
    (attach table halign2 0 1 4 5 GTK_FILL      GTK_FILL      0 0)

    (set-size-request  okBtn 70 30)
    (attach table okBtn   3 4 4 5 GTK_FILL      GTK_FILL      0 0)

    (add window table)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(windows)
(gtk-main)
