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
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.fixed"))

(define (layout-gtkfixed app)
  (let ([window (make <GtkWindow> #:application     app
                                  #:default-width   290
                                  #:default-height  200
                                  #:window-position (symbol->enum
                                                      <GtkWindowPosition>
                                                      'center)
                                  #:title           "GtkFixed")]
        [fixed  (make <GtkFixed>)]
        [button1 (make <GtkButton> #:label          "Button1"
                                   #:width-request  80
                                   #:height-request 35)]
        [button2 (make <GtkButton> #:label          "Button2"
                                   #:width-request  80
                                   #:height-request 35)]
        [button3 (make <GtkButton> #:label          "Button3"
                                   #:width-request  80
                                   #:height-request 35)])
    (add window fixed)

    (put fixed button1 150  50)
    (put fixed button2  15  15)
    (put fixed button3 100 100)

    (show-all window)))

(connect app activate layout-gtkfixed)
(run app (command-line))
