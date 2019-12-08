(use-modules (gnome-2)       (oop   goops)
             (gnome gobject) (srfi  srfi-11)
             (gnome gtk)     (gnome gtk     gdk-event))

(define (on-button-press window event)
  (define LEFT_CLICK 1)

  (when (eq? (gdk-event:type event) 'button-press)
    (when (= (gdk-event-button:button event) LEFT_CLICK)
      (let-values ([(ret x y) (gdk-event-get-root-coords event)])
        (begin-move-drag
          (get-toplevel window)
          (gdk-event-button:button event)
          (inexact->exact (round x))
          (inexact->exact (round y))
          (gdk-event-button:time event)))))

  #t)

(define (drag-drop)
  (let ([window (gtk-window-new 'toplevel)])
    (set-title        window "Drag & drop")
    (set-default-size window 250 200)
    (set-position     window 'center)
    (set-decorated    window #f)
    (add-events       window (make <gdk-event-mask> #:value 'button-press-mask))

    (connect window 'button-press-event on-button-press)
    (connect window 'destroy            (lambda (w) (gtk-main-quit)))

    (show-all window)))

(drag-drop)
(gtk-main)
