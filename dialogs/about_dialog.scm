(use-modules (gnome-2) (oop goops) (gnome gtk))

(define (show-about win event)
  (define pixbuf (gdk-pixbuf-new-from-file "battery.png"))
  ;; (define dialog (gtk-about-dialog-new))
  ;;
  ;; Set comments doesn't seem to be a function made available
  ;; So we'll have to do this through make
  ;; (set-comments  dialog "Battery is a simple tool for battery checking.")
  (define dialog (make <gtk-about-dialog>
                   #:comments "Battery is a simple tool for battery checking."))

  (set-name      dialog "Battery")
  (set-version   dialog "0.9")
  (set-copyright dialog "(c) Jan Bodnar")
  (set-website   dialog "http://www.batteryhq.net")
  (set-logo      dialog pixbuf)

  (run     dialog)
  (destroy dialog)

  #t)

(define (dialog)
  (let ([window  (gtk-window-new 'toplevel)])
    (set-title        window "Battery")
    (set-default-size window 220 150)
    (set-position     window 'center)
    (set-border-width window 15)
    (add-events       window (make <gdk-event-mask> #:value 'button-press-mask))

    (connect window 'button-press-event show-about)
    (connect window 'destroy            (lambda (w) (gtk-main-quit)))

    (show-all window)))

(dialog)
(gtk-main)
