(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gtk" "Alignment")
(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "AttachOptions")
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Label")
(load-by-name "Gtk" "Table")
(load-by-name "Gtk" "TextView")
(load-by-name "Gtk" "Widget") ;; show-all

(define GTK_EXPAND       (symbol->enum <GtkAttachOptions> 'expand))
(define GTK_SHRINK       (symbol->enum <GtkAttachOptions> 'shrink))
(define GTK_FILL         (symbol->enum <GtkAttachOptions> 'fill))
(define GTK_FILLorEXPAND (list->flags  <GtkAttachOptions> '(fill expand)))
(define app              (make <GtkApplication> #:application-id "org.gtk.wins"))

(define (windows app)
  (let ([window  (make <GtkWindow>    #:application     app
                                      #:border-width    15
                                      #:default-width   300
                                      #:default-height  250
                                      #:window-position (symbol->enum
                                                          <GtkWindowPosition>
                                                          'center)
                                      #:title           "Windows")]
        [table   (make <GtkTable>     #:n-rows      6
                                      #:n-columns   4  #:column-spacing 3
                                      #:homogeneous #f)]
        [title   (make <GtkLabel>     #:label "Windows")]
        [wins    (make <GtkTextView>  #:editable #f #:cursor-visible #f)]
        [halign  (make <GtkAlignment> #:xalign 0 #:yalign 0
                                      #:xscale 0 #:yscale 0)]
        [halign2 (make <GtkAlignment> #:xalign 0 #:yalign 1
                                      #:xscale 0 #:yscale 0)]
        [valign  (make <GtkAlignment> #:xalign 0 #:yalign 0
                                      #:xscale 0 #:yscale 0)]
        [actBtn  (make <GtkButton>    #:label          "Activate"
                                      #:width-request  50
                                      #:height-request 30)]
        [clsBtn  (make <GtkButton>    #:label          "Close"
                                      #:width-request  70
                                      #:height-request 30)]
        [hlpBtn  (make <GtkButton>    #:label          "Help"
                                      #:width-request  70
                                      #:height-request 30)]
        [ okBtn  (make <GtkButton>    #:label          "OK"
                                      #:width-request  70
                                      #:height-request 30)])
    (set-row-spacing table 0 3)

    (add halign title)
    (attach table halign  0 1 0 1 GTK_FILL         GTK_FILL         0 0)
    (attach table wins    0 2 1 3 GTK_FILLorEXPAND GTK_FILLorEXPAND 1 1)
    (attach table actBtn  3 4 1 2 GTK_FILL         GTK_SHRINK       0 0)

    (add valign  clsBtn)

    (set-row-spacing table 1 3)
    (attach table valign  3 4 2 3 GTK_FILL         GTK_FILLorEXPAND 1 1)

    (add halign2 hlpBtn)

    (set-row-spacing table 3 5)

    (attach table halign2 0 1 4 5 GTK_FILL         GTK_FILL         0 0)
    (attach table okBtn   3 4 4 5 GTK_FILL         GTK_FILL         0 0)

    (add window table)

    (show-all window)))

(connect app activate windows)
(run app (command-line))
