(use-modules (gnome-2) (oop goops) (gnome gtk))

(define GTK_FILL (make <gtk-attach-options> #:value 'fill))

(define (show-info     wi)
  (define dialog (%gtk-message-dialog-new
                   wi
                   (make <gtk-dialog-flags> #:value 'destroy-with-parent)
                   (make <gtk-message-type> #:value 'info)
                   (make <gtk-buttons-type> #:value 'ok)
                   "Download Completed"))

  (set-title wi "Information")
  (run     dialog)
  (destroy dialog))

(define (show-error    win)
  (define dialog (%gtk-message-dialog-new
                   win
                   (make <gtk-dialog-flags> #:value 'destroy-with-parent)
                   (make <gtk-message-type> #:value 'error)
                   (make <gtk-buttons-type> #:value 'ok)
                   "Error loading file"))

  (set-title dialog "Error")
  (run     dialog)
  (destroy dialog))

(define (show-question wind)
  (define dialog (%gtk-message-dialog-new
                   wind
                   (make <gtk-dialog-flags> #:value 'destroy-with-parent)
                   (make <gtk-message-type> #:value 'question)
                   (make <gtk-buttons-type> #:value 'yes-no)
                   "Are you sure to quit?"))

  (set-title dialog "Question")
  (run     dialog)
  (destroy dialog))

(define (show-warning  windo)
  (define dialog (%gtk-message-dialog-new
                   windo
                   (make <gtk-dialog-flags> #:value 'destroy-with-parent)
                   (make <gtk-message-type> #:value 'warning)
                   (make <gtk-buttons-type> #:value 'ok)
                   "Unallowed operation"))

  (set-title dialog "Warning")
  (run     dialog)
  (destroy dialog))

(define (dialog)
  (let ([window (gtk-window-new 'toplevel)]
        [table  (gtk-table-new 2 2 #t)]
        [info   (gtk-button-new-with-label "Info")]
        [warn   (gtk-button-new-with-label "Warning")]
        [que    (gtk-button-new-with-label "Question")]
        [err    (gtk-button-new-with-label "Error")])
    (set-title        window "Message dialogs")
    (set-default-size window 220 150)
    (set-position     window 'center)
    (set-border-width window 15)

    (set-row-spacings table 2)
    (set-col-spacings table 2)

    (attach table info 0 1 0 1 GTK_FILL GTK_FILL 3 3)
    (attach table warn 1 2 0 1 GTK_FILL GTK_FILL 3 3)
    (attach table que  0 1 1 2 GTK_FILL GTK_FILL 3 3)
    (attach table err  1 2 1 2 GTK_FILL GTK_FILL 3 3)

    (add window table)

    (connect info   'clicked (lambda (i) (show-info     window)))
    (connect warn   'clicked (lambda (w) (show-warning  window)))
    (connect que    'clicked (lambda (q) (show-question window)))
    (connect err    'clicked (lambda (e) (show-error    window)))
    (connect window 'destroy (lambda (w) (gtk-main-quit)))

    (show-all window)))

(dialog)
(gtk-main)
