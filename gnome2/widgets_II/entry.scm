(use-modules (gnome-2) (oop goops) (gnome gtk))

(define FILLorSHRINK (make <gtk-attach-options> #:value '(fill shrink)))

(define (entry)
  (let ([window (gtk-window-new 'toplevel)]
        [table  (gtk-table-new 3 2 #f)]
        [label1 (gtk-label-new "Name")]
        [label2 (gtk-label-new "Age")]
        [label3 (gtk-label-new "Occupation")]
        [entry1 (make <gtk-entry>)]
        [entry2 (make <gtk-entry>)]
        [entry3 (make <gtk-entry>)])
    (set-title        window "GtkEntry")
    (set-position     window 'center)
    (set-border-width window 10)

    (add window table)

    (attach table label1 0 1 0 1 FILLorSHRINK FILLorSHRINK 5 5)
    (attach table label2 0 1 1 2 FILLorSHRINK FILLorSHRINK 5 5)
    (attach table label3 0 1 2 3 FILLorSHRINK FILLorSHRINK 5 5)
    (attach table entry1 1 2 0 1 FILLorSHRINK FILLorSHRINK 5 5)
    (attach table entry2 1 2 1 2 FILLorSHRINK FILLorSHRINK 5 5)
    (attach table entry3 1 2 2 3 FILLorSHRINK FILLorSHRINK 5 5)

    (show-all window)

    (connect window 'destroy (lambda (w) (gtk-main-quit)))))

(entry)
(gtk-main)
