(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Box") ;; pack-start
(load-by-name "Gtk" "ColorSelection")
(load-by-name "Gtk" "ColorSelectionDialog")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Dialog")
(load-by-name "Gtk" "Label")
(load-by-name "Gtk" "ResponseType")
(load-by-name "Gtk" "StateFlags")
(load-by-name "Gtk" "Toolbar")
(load-by-name "Gtk" "ToolbarStyle")
(load-by-name "Gtk" "ToolButton")
(load-by-name "Gtk" "VBox")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.colorSelect"))

(define (select-font fontBtn lbl)
  (define dialog (make <GtkColorSelectionDialog> #:title "Font Color"))
  (define result (run dialog))

  (when (= result (enum->number (symbol->enum <GtkResponseType> 'ok)))
    ;; I can't figure out why this won't work
    ;; Seemingly, it says it only takes two arguments but parsing out
    ;; what these functions do is unyielding and it doesn't match with
    ;; the Gnome documentation for this function (widget:modify-fg)
    (modify-fg
      lbl
      (symbol->enum <GtkStateFlags> 'normal)
      (current-color (get-color-selection dialog))))

  (destroy dialog))

(define (color app)
  (let ([window  (make <GtkWindow>     #:application     app
                                       #:default-width   280
                                       #:default-height  200
                                       #:window-position (symbol->enum
                                                           <GtkWindowPosition>
                                                           'center)
                                       #:title           "Color Selection Dialog")]
        [label   (make <GtkLabel>      #:label "ZetCode" #:justify 'center)]
        [vbox    (make <GtkVBox>       #:homogeneous #f #:spacing 0)]
        [toolbar (make <GtkToolbar>    #:toolbar-style (symbol->enum
                                                         <GtkToolbarStyle>
                                                         'icons)
                                       #:border-width  2)]
        [font    (make <GtkToolButton> #:stock-id "gtk-select-color")])
    (add window vbox)

    (insert toolbar font -1)

    (pack-start vbox toolbar #f #f 5)
    (pack-start vbox label   #t #f 5)

    (connect font clicked (lambda (f) (select-font f label)))

    (show-all window)))

(connect app activate color)
(run app (command-line))
