(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gtk" "Alignment")
(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.buttonClick"))

(define (button-clicked button)
  (display "clicked")

  (newline))

(define (click a)
  (let ([window (make <GtkWindow>    #:application     a
                                     #:border-width    15
                                     #:default-width   300
                                     #:default-height  200
                                     #:window-position (symbol->enum
                                                         <GtkWindowPosition>
                                                         'center)
                                     #:title           "GtkButton")]
        [halign (make <GtkAlignment> #:xalign 0 #:yalign 0
                                     #:xscale 0 #:yscale 0)]
        [btn    (make <GtkButton>    #:label          "Click"
                                     #:width-request  70
                                     #:height-request 30)])
    (add halign btn)
    (add window halign)

    (connect btn clicked button-clicked)

    (show-all window)))

(connect app activate click)
(run app (command-line))

