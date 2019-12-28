(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Table")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.table"))

(define (enumerate-interval low high)
  (if (> low high)
      '()
    (cons low (enumerate-interval (+ low 1) high))))

(define (layout-gtktable app)
  (let ([window (make <GtkWindow> #:application     app
                                  #:border-width    5
                                  #:default-width   250
                                  #:default-height  180
                                  #:window-position (symbol->enum
                                                      <GtkWindowPosition>
                                                      'center)
                                  #:title           "GtkTable")]
        [table  (make <GtkTable>  #:n-rows      4  #:row-spacing    2
                                  #:n-columns   4  #:column-spacing 2
                                  #:homogeneous #t)]
        [values (list "7" "8" "9" "/"
                      "4" "5" "6" "*"
                      "1" "2" "3" "-"
                      "0" "." "=" "+")])
    (let ([n 0])
      (for-each
        (lambda (i)
          (for-each
            (lambda (j)
              (let ([button (make <GtkButton> #:label (list-ref values n))])
                (attach-defaults table button j (+ j 1) i (+ i 1)))

              (set! n (+ n 1)))
            (enumerate-interval 0 3)))
        (enumerate-interval 0 3)))

    (add window table)

    (show-all window)))

(connect app activate layout-gtktable)
(run app (command-line))
