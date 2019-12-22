(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.centerWindow"))

(define (centering-window app)
  (let ([window (make <GtkWindow> #:application     app
                                  #:default-width   230
                                  #:default-height  150
                                  #:window-position (symbol->enum
                                                      <GtkWindowPosition>
                                                      'center)
                                  #:title           "Center")])
    ;; No longer necessary
    ;; (connect window destroy (lambda (w) (destroy w)))

    (show-all window)))

(connect app activate centering-window)
(run app (command-line))
