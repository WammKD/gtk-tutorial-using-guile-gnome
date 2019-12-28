(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "Window") ;; set-title
(load-by-name "Gtk" "WindowPosition")
(load-by-name "Gtk" "AttachOptions")
(load-by-name "Gtk" "Button")
(load-by-name "Gtk" "ButtonsType")
(load-by-name "Gtk" "Container") ;; add
(load-by-name "Gtk" "Dialog")
;; (load-by-name "Gtk" "DialogFlags")
(load-by-name "Gtk" "MessageDialog")
(load-by-name "Gtk" "MessageType")
(load-by-name "Gtk" "Table")
(load-by-name "Gtk" "Widget") ;; show-all

(define app      (make <GtkApplication> #:application-id "org.gtk.message"))
(define GTK_FILL (symbol->enum <GtkAttachOptions> 'fill))

(define (show-info wi)
  (define dialog (make <GtkMessageDialog> #:transient-for wi
                                          ;; #:flags         (symbol->enum
                                          ;;                   <GtkDialogFlags>
                                          ;;                   'destroy-with-parent)
                                          #:message-type  (symbol->enum
                                                            <GtkMessageType>
                                                            'info)
                                          #:buttons       (symbol->enum
                                                            <GtkButtonsType>
                                                            'ok)
                                          #:text          "Download Completed"))

  (set-title wi "Information")
  (run     dialog)
  (destroy dialog))

(define (show-error win)
  (define dialog (make <GtkMessageDialog> #:transient-for win
                                          ;; #:flags         (symbol->enum
                                          ;;                   <GtkDialogFlags>
                                          ;;                   'destroy-with-parent)
                                          #:message-type  (symbol->enum
                                                            <GtkMessageType>
                                                            'error)
                                          #:buttons       (symbol->enum
                                                            <GtkButtonsType>
                                                            'ok)
                                          #:text          "Error loading file"))

  (set-title win "Error")
  (run     dialog)
  (destroy dialog))

(define (show-question wind)
  (define dialog (make <GtkMessageDialog> #:transient-for wind
                                          ;; #:flags         (symbol->enum
                                          ;;                   <GtkDialogFlags>
                                          ;;                   'destroy-with-parent)
                                          #:message-type  (symbol->enum
                                                            <GtkMessageType>
                                                            'question)
                                          #:buttons       (symbol->enum
                                                            <GtkButtonsType>
                                                            'yes-no)
                                          #:text          "Are you sure to quit?"))

  (set-title wind "Question")
  (run     dialog)
  (destroy dialog))

(define (show-warning windo)
  (define dialog (make <GtkMessageDialog> #:transient-for windo
                                          ;; #:flags         (symbol->enum
                                          ;;                   <GtkDialogFlags>
                                          ;;                   'destroy-with-parent)
                                          #:message-type  (symbol->enum
                                                            <GtkMessageType>
                                                            'warning)
                                          #:buttons       (symbol->enum
                                                            <GtkButtonsType>
                                                            'ok)
                                          #:text          "Unallowed operation"))

  (set-title windo "Warning")
  (run     dialog)
  (destroy dialog))

(define (dialog a)
  (let ([window (make <GtkWindow> #:application     a
                                  #:border-width    15
                                  #:default-width   220
                                  #:default-height  150
                                  #:window-position (symbol->enum
                                                      <GtkWindowPosition>
                                                      'center)
                                  #:title           "Message dialogs")]
        [table  (make <GtkTable>  #:n-rows      2  #:row-spacing    2
                                  #:n-columns   2  #:column-spacing 2
                                  #:homogeneous #t)]
        [info   (make <GtkButton> #:label "Info")]
        [warn   (make <GtkButton> #:label "Warning")]
        [que    (make <GtkButton> #:label "Question")]
        [err    (make <GtkButton> #:label "Error")])
    (attach table info 0 1 0 1 GTK_FILL GTK_FILL 3 3)
    (attach table warn 1 2 0 1 GTK_FILL GTK_FILL 3 3)
    (attach table que  0 1 1 2 GTK_FILL GTK_FILL 3 3)
    (attach table err  1 2 1 2 GTK_FILL GTK_FILL 3 3)

    (add window table)

    (connect info clicked (lambda (i) (show-info     window)))
    (connect warn clicked (lambda (w) (show-warning  window)))
    (connect que  clicked (lambda (q) (show-question window)))
    (connect err  clicked (lambda (e) (show-error    window)))

    (show-all window)))

(connect app activate dialog)
(run app (command-line))
