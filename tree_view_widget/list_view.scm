(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk) (ice-9 receive))

(genum-register-static "enum" #((LIST_ITEM "List Item Index"   0)
                                (N_COLUMNS "Number of Columns" 1)))
(define LIST_ITEM (make (gtype-name->class "enum") #:value 0))
(define N_COLUMNS (make (gtype-name->class "enum") #:value 1))

(define (init-list tView)
  (define store    (gtk-list-store-new (list <gchararray>)))
  (define renderer (gtk-cell-renderer-text-new))
  (define column   (gtk-tree-view-column-new))

  (set-title     column "List Items")
  (pack-start    column renderer #f)
  (add-attribute column renderer "text" (genum->value LIST_ITEM))

  (append-column tView column)
  (set-model     tView store))

(define (add-to-list treeView str)
  (define store (get-model treeView))

  (set-value store (gtk-list-store-append store) (genum->value LIST_ITEM) str))

(define (on-changed treeSelection lbl)
  (receive (model iter)
      (get-selected treeSelection)
    (when (and model iter)
      (set-text lbl (get-value model iter (genum->value LIST_ITEM))))))

(define (list-view)
  (let ([window    (gtk-window-new 'toplevel)]
        [lst       (gtk-tree-view-new)]
        [vbox      (gtk-vbox-new #f 0)]
        [label     (gtk-label-new "")])
    (set-title        window "List view")
    (set-position     window 'center)
    (set-border-width window 10)
    (set-default-size window 270 250)

    (set-headers-visible lst #f)

    (pack-start vbox lst   #t #t 5)
    (pack-start vbox label #f #f 5)

    (add window vbox)

    (init-list   lst)
    (add-to-list lst "Aliens")
    (add-to-list lst "Leon")
    (add-to-list lst "The Verdict")
    (add-to-list lst "North Face")
    (add-to-list lst "Der Untergang")

    (connect (get-selection lst) 'changed (lambda (s) (on-changed s label)))
    (connect window              'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(list-view)
(gtk-main)
