(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gtk" "Alignment")
(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Box") ;; pack-start
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "HBox")
(load-by-name "Gtk" "VBox")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.cornerButtons"))

(define (corner-buttons app)
  (let ([window (make <GtkWindow>    #:application     app
                                     #:border-width    10
                                     #:default-width   350
                                     #:default-height  200
                                     #:window-position (symbol->enum
                                                         <GtkWindowPosition>
                                                         'center)
                                     #:title           "Corner buttons")]
        [ okBtn (make <GtkButton>    #:label          "OK"
                                     #:width-request  70
                                     #:height-request 30)]
        [clsBtn (make <GtkButton>    #:label "Close")]
        [vbox   (make <GtkVBox>      #:homogeneous #f #:spacing 0)]
        [hbox   (make <GtkHBox>      #:homogeneous #t #:spacing 3)]
        [halign (make <GtkAlignment> #:xalign 1 #:yalign 0
                                     #:xscale 0 #:yscale 0)]
        [valign (make <GtkAlignment> #:xalign 0 #:yalign 1
                                     #:xscale 0 #:yscale 0)])
    (add vbox   valign)
    (add window vbox)

    (add hbox okBtn)
    (add hbox clsBtn)

    (add halign hbox)

    (pack-start vbox halign #f #f 0)

    (show-all window)))

(connect app activate corner-buttons)
(run app (command-line))
