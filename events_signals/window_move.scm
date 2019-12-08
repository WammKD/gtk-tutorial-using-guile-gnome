(use-modules (gnome-2)       (oop   goops)
             (gnome gobject) (srfi  srfi-11)
             (gnome gtk)     (gnome gtk     gdk-event))

(define (configure-callback windo event)
  (let-values ([(ret x y) (gdk-event-get-coords event)])
    (set-title windo (string-append (number->string x) ", " (number->string y)))

    #t))

(define (move)
  (let ([window (gtk-window-new 'toplevel)])
    (set-default-size window 300 200)
    (set-position     window 'center)
    (set-border-width window 15)
    ;; The example clearly shows feeding "GDK_CONFIGURE", a <gdk-event-type>, to
    ;; gtk_widget_add_events but Guile shows gtk-widget-add-events/add-events as
    ;; taking a <gdk-event-mask>.
    ;;
    ;; However, ignoring this portion of the code, entirely, doesn't seem to
    ;; affect anything as connect clearly is able to pick up configure events
    ;; just by specifying them.
    ;;
    ;; The tutorial mentions that the event mask of the widget will determine
    ;; what kind of events it will receive. I dunno if the Guile library just
    ;; does it behind the scenes or the tutorial is outdated but it seems that
    ;; the window is already outfitted to handle configure events (thankfully,
    ;; seeing as we certainly can't add them via this function…)
    ;; (add-events       window 13)  ;GDK_CONFIGURE

    (connect window 'destroy         (lambda (w) (gtk-main-quit)))
    (connect window 'configure-event configure-callback)

    (show-all window)))

(move)
(gtk-main)
