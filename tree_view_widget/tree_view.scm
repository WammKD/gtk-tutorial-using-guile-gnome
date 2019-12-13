(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk) (ice-9 receive))

(genum-register-static "enum" #((COLUMN   "Column Index"      0)
                                (NUM_COLS "Number of Columns" 1)))
(define COLUMN   (make (gtype-name->class "enum") #:value 0))
(define NUM_COLS (make (gtype-name->class "enum") #:value 1))



(define (on-changed treeSelection sttsBar)
  (receive (model iter)
      (get-selected treeSelection)
    (when (and model iter)
      (let ([value (get-value model iter (genum->value COLUMN))])
        (push sttsBar (get-context-id sttsBar value) value)))))

(define (create-and-fill-model)
  (define treestore (gtk-tree-store-new (list <gchararray>)))

  (let ([toplevel              (gtk-tree-store-append treestore #f)])
    (set treestore toplevel (genum->value COLUMN) "Scripting Languages")

    (set treestore             (gtk-tree-store-append treestore toplevel)
         (genum->value COLUMN) "Python")

    (set treestore             (gtk-tree-store-append treestore toplevel)
         (genum->value COLUMN) "Perl")

    (set treestore             (gtk-tree-store-append treestore toplevel)
         (genum->value COLUMN) "PHP"))

  (let ([toplevel              (gtk-tree-store-append treestore #f)])
    (set treestore toplevel (genum->value COLUMN) "Compiled Languages")

    (set treestore             (gtk-tree-store-append treestore toplevel)
         (genum->value COLUMN) "C")

    (set treestore             (gtk-tree-store-append treestore toplevel)
         (genum->value COLUMN) "C++")

    (set treestore             (gtk-tree-store-append treestore toplevel)
         (genum->value COLUMN) "Java"))

  treestore)

(define (create-view-and-model)
  (define view     (gtk-tree-view-new))
  (define col      (gtk-tree-view-column-new))
  (define renderer (gtk-cell-renderer-text-new))
  (define model    (create-and-fill-model))

  (set-title     col  "Programing Languages")
  (append-column view col)

  (pack-start    col renderer #t)
  (add-attribute col renderer "text" (genum->value COLUMN))

  (set-model view model)

  view)

(define (tree-view)
  (let* ([window    (gtk-window-new 'toplevel)]
         [view      (create-view-and-model)]
         [selection (get-selection view)]
         [vbox      (gtk-vbox-new #f 2)]
         [statusbar (gtk-statusbar-new)])
    (set-position     window 'center)
    (set-title        window "Tree view")
    (set-size-request window 350 300)

    (add window vbox)

    (pack-start vbox view      #t #t 1)
    (pack-start vbox statusbar #f #t 1)

    (connect selection 'changed (lambda (s) (on-changed s statusbar)))
    (connect window    'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(tree-view)
(gtk-main)
