(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (update-statusbar bffr sttsBar)
  (define iter (get-iter-at-mark bffr (get-insert bffr)))
  (define row  (gtk-text-iter-get-line        iter))
  (define col  (gtk-text-iter-get-line-offset iter))
  (define msg  (string-append "Col: " (number->string (1+ col))
                              " Ln: " (number->string (1+ row))))

  (pop  sttsBar 0)
  (push sttsBar 0 msg))

(define (mark-set-callback buff statusB)
  (update-statusbar buff statusB))  ; in the original code, they had to
                                    ; handle two more args being passed

(define (lines-columns)
  (let* ([window    (gtk-window-new 'toplevel)]
         [vbox      (gtk-vbox-new #f 0)]
         [toolbar   (gtk-toolbar-new)]
         [view      (gtk-text-view-new-with-buffer)]
         [statusbar (gtk-statusbar-new)]
         [exit      (gtk-tool-button-new-from-stock (gtk-stock-id 'quit))]
         [buffer    (get-buffer view)])
    (set-position     window 'center)
    (set-default-size window 350 300)
    (set-title        window "Lines & columns")

    (add window vbox)

    (set-style toolbar 'icons)
    (insert    toolbar exit -1)

    (pack-start vbox toolbar #f #f 5)

    (set-wrap-mode view (make <gtk-wrap-mode> #:value 'word))

    (pack-start vbox view #t #t 0)

    (grab-focus view)

    (pack-start vbox statusbar #f #f 0)

    (connect exit   'clicked  (lambda (e) (gtk-main-quit)))
    (connect buffer 'changed  (lambda (b) (update-statusbar  b statusbar)))
    (connect buffer 'mark-set (lambda (buff newLocation mark)
                                (mark-set-callback buff statusbar)))
    (connect window 'destroy  (lambda (w) (gtk-main-quit)))

    (show-all window)

    (update-statusbar buffer statusbar)))

(lines-columns)
(gtk-main)
