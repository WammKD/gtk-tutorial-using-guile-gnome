(use-modules (gi) (gi repository) (gi types))

(use-typelibs ("Pango" "1.0"))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "Box") ;; pack-start
(load-by-name "Gtk" "FontSelectionDialog")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Dialog")
(load-by-name "Gtk" "Label")
(load-by-name "Gtk" "ResponseType")
(load-by-name "Gtk" "Toolbar")
(load-by-name "Gtk" "ToolbarStyle")
(load-by-name "Gtk" "ToolButton")
(load-by-name "Gtk" "VBox")
(load-by-name "Gtk" "Widget") ;; show-all

(define app (make <GtkApplication> #:application-id "org.gtk.fontSelect"))

(define (select-font fontBtn lbl)
  (define dialog (make <GtkFontSelectionDialog> #:title "Select Font"))
  (define result (run dialog))

  (when (or
          (= result (enum->number (symbol->enum <GtkResponseType> 'ok)))
          (= result (enum->number (symbol->enum <GtkResponseType> 'apply))))
    (modify-font
      lbl
      (font-description-from-string (get-font-name dialog))))

  (destroy dialog))

(define (font app)
  (let ([window  (make <GtkWindow>     #:application     app
                                       #:default-width   280
                                       #:default-height  200
                                       #:window-position (symbol->enum
                                                           <GtkWindowPosition>
                                                           'center)
                                       #:title           "Font Selection Dialog")]
        [label   (make <GtkLabel>      #:label "ZetCode" #:justify 'center)]
        [vbox    (make <GtkVBox>       #:homogeneous #f #:spacing 0)]
        [toolbar (make <GtkToolbar>    #:toolbar-style (symbol->enum
                                                         <GtkToolbarStyle>
                                                         'icons)
                                       #:border-width  2)]
        [font    (make <GtkToolButton> #:stock-id "gtk-select-font")])
    (add window vbox)

    (insert toolbar font -1)

    (pack-start vbox toolbar #f #f 5)
    (pack-start vbox label   #t #f 5)

    (connect font clicked (lambda (f) (select-font f label)))

    (show-all window)))

(connect app activate font)
(run app (command-line))
