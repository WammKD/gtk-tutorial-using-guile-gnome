(use-modules (gi) (gi repository) (gi types))

(use-typelibs ("GObject" "2.0"))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Box") ;; pack-start
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "CheckButton")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "HBox")
(load-by-name "Gtk" "ToggleButton")
(load-by-name "Gtk" "VBox")
(load-by-name "Gtk" "Widget") ;; show-all

(define app       (make <GtkApplication> #:application-id "org.gtk.callback"))
(define handlerID #f)

(define (button-clicked button)
  (display "clicked")

  (newline))

(define (toogle-signal checkedButton button)
  (if (get-active? checkedButton)
      (set! handlerID (connect button clicked button-clicked))
    (signal-handler-disconnect button handlerID)))

(define (disconnect a)
  (let ([window (make <GtkWindow>      #:application     app
                                       #:border-width    15
                                       #:default-width   300
                                       #:default-height  200
                                       #:window-position (symbol->enum
                                                           <GtkWindowPosition>
                                                           'center)
                                       #:title           "Disconnect")]
        [hbox   (make <GtkHBox>        #:homogeneous #f #:spacing 15)]
        [vbox   (make <GtkVBox>        #:homogeneous #f #:spacing  5)]
        [btn    (make <GtkButton>      #:label          "Click"
                                       #:width-request  70
                                       #:height-request 30)]
        [cb     (make <GtkCheckButton> #:label "Connect" #:active #t)])
    (pack-start hbox btn  #f #f 0)
    (pack-start hbox cb   #f #f 0)
    (pack-start vbox hbox #f #f 0)

    (add window vbox)

    (set! handlerID (connect btn clicked button-clicked))
    (connect cb clicked (lambda (c) (toogle-signal c btn)))

    (show-all window)))

(connect app activate disconnect)
(run app (command-line))
