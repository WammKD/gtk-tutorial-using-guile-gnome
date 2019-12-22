(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gtk" "Alignment")
(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Label")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.alignment"))

(define (alignment app)
  (let ([window (make <GtkWindow> #:application     app
                                  #:default-height  150
                                  #:default-width   230
                                  #:window-position (symbol->enum
                                                      <GtkWindowPosition>
                                                      'center)
                                  #:title           "GtkAlignment")]
