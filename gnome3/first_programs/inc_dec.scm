(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Fixed")
(load-by-name "Gtk" "Label")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.incDec"))

(define (inc-dec app)
  (let ([window (make <GtkWindow> #:application     app
                                  #:default-height  150
                                  #:default-width   230
                                  #:window-position (symbol->enum
                                                      <GtkWindowPosition>
                                                      'center)
                                  #:title           "+-")]
        [frame  (make <GtkFixed>)]
        [plus   (make <GtkButton> #:label "+")]
        [minus  (make <GtkButton> #:label "-")]
        [label  (make <GtkLabel>  #:label "0")]
        [count  0])
    (add window frame)

    (set-size-request plus 80 35)
    (put frame plus 50 20)

    (set-size-request minus 80 35)
    (put frame minus 50 80)

    (put frame label 190 58)

    ;; No longer necessary, the destroy part
    (connect window destroy (lambda (w) (destroy window)))
    (connect plus   clicked (lambda (b)
                              (set! count (1+ count))

                              (set-text label (number->string count))))
    (connect minus  clicked (lambda (b)
                              (set! count (1- count))

                              (set-text label (number->string count))))

    (show-all window)))

(connect app activate inc-dec)
(run app (command-line))
