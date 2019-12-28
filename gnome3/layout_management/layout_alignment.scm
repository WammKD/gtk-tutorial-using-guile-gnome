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
  (let ([window (make <GtkWindow>    #:title           "GtkAlignment"
                                     #:application     app
                                     #:border-width    5
                                     #:default-width   300
                                     #:default-height  200
                                     #:window-position (symbol->enum
                                                         <GtkWindowPosition>
                                                         'center))]
        [align  (make <GtkAlignment> #:xalign 0 #:yalign 1
                                     #:xscale 0 #:yscale 0)]
        [lbl    (make <GtkLabel>     #:label "bottom-left")])
    (add align  lbl)
    (add window align)

    (show-all window)))

(connect app activate alignment)
(run app (command-line))
