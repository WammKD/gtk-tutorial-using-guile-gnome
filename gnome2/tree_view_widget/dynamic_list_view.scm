(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk) (ice-9 receive))

(genum-register-static "enum" #((LIST_ITEM "List Item Index"   0)
                                (N_COLUMNS "Number of Columns" 1)))
(define LIST_ITEM (make (gtype-name->class "enum") #:value 0))
(define N_COLUMNS (make (gtype-name->class "enum") #:value 1))



(define (append-item entryObj treeView)
  (define store (get-model treeView))

  (set store                    (gtk-list-store-append store)
       (genum->value LIST_ITEM) (get-text entryObj))
  (set-text entryObj ""))

(define (remove-item treeSelection treeV)
  (define store (get-model treeV))

  (when (get-iter-first store)
    (receive (model iter)
        (get-selected treeSelection)
      (when (and model iter)
        (remove store iter)))))

(define (remove-all tv)
  (define store (get-model tv))

  (when (get-iter-first store)
    (clear store)))

(define (init-list tView)
  (define store    (gtk-list-store-new (list <gchararray>)))
  (define renderer (gtk-cell-renderer-text-new))
  (define column   (gtk-tree-view-column-new))

  (set-title     column "List Items")
  (pack-start    column renderer #f)
  (add-attribute column renderer "text" (genum->value LIST_ITEM))

  (append-column tView column)
  (set-model     tView store))

(define (dynamic)
  (let ([window       (gtk-window-new 'toplevel)]
        [sw           (gtk-scrolled-window-new)]
        [removeBtn    (gtk-button-new-with-label "Remove")]
        [addBtn       (gtk-button-new-with-label "Add")]
        [removeAllBtn (gtk-button-new-with-label "Remove All")]
        [entry        (make <gtk-entry>)]
        [vbox         (gtk-vbox-new #f 0)]
        [hbox         (gtk-hbox-new #f 5)]
        [lst          (gtk-tree-view-new)])
    (set-title        window "List view")
    (set-position     window 'center)
    (set-border-width window 10)
    (set-default-size window 370 270)

    (add             sw lst)
    (set-policy      sw (make <gtk-policy-type> #:value 'automatic)
                        (make <gtk-policy-type> #:value 'automatic))
    (set-shadow-type sw (make <gtk-shadow-type> #:value 'etched-in))

    (set-headers-visible lst #f)

    (pack-start vbox sw #t #t 5)

    (set-size-request entry 120 -1)

    (pack-start hbox addBtn       #f #t 3)
    (pack-start hbox entry        #f #t 3)
    (pack-start hbox removeBtn    #f #t 3)
    (pack-start hbox removeAllBtn #f #t 3)

    (pack-start vbox hbox      #f #t 3)

    (add window vbox)

    (init-list lst)

    (connect addBtn       'clicked (lambda (a)  (append-item entry               lst)))
    (connect removeBtn    'clicked (lambda (r)  (remove-item (get-selection lst) lst)))
    (connect removeAllBtn 'clicked (lambda (ra) (remove-all  lst)))
    (connect window       'destroy (lambda (w)  (gtk-main-quit)))

    (show-all window)))

(dynamic)
(gtk-main)
