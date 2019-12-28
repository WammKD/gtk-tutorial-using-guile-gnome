(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Box") ;; pack-start
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "VBox")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.vbox"))

(define (layout-gtkvbox app)
  (let ([window   (make <GtkWindow> #:application     app
                                    #:border-width    5
                                    #:default-width   230
                                    #:default-height  250
                                    #:window-position (symbol->enum
                                                        <GtkWindowPosition>
                                                        'center)
                                    #:title           "GtkVBox")]
        [settings (make <GtkButton> #:label "Settings")]
        [accounts (make <GtkButton> #:label "Accounts")]
        [loans    (make <GtkButton> #:label "Loans")]
        [debts    (make <GtkButton> #:label "Debts")]
        [vbox     (make <GtkVBox>   #:homogeneous #t #:spacing 1)])
    (add window vbox)

    (pack-start vbox settings #t #t 0)
    (pack-start vbox accounts #t #t 0)
    (pack-start vbox loans    #t #t 0)
    (pack-start vbox debts    #t #t 0)

    (show-all window)))

(connect app activate layout-gtkvbox)
(run app (command-line))
