(use-modules (gi) (gi repository))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.simple"))

(define (simple-window app)
  (let ([window (make <GtkWindow> #:application app)])
    (show-all window)))

(connect app activate simple-window)
(run app (command-line))
