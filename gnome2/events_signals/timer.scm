(use-modules (gnome-2)    (cairo)
             (gnome glib) (oop   goops)
             (gnome gtk)  (srfi  srfi-19))

(define buf #f)

(define (on-expose-event drawingArea event)
  (define cr (gdk-cairo-create (get drawingArea 'window)))

  (cairo-move-to       cr 30 30)
  (cairo-set-font-size cr 15)
  (cairo-show-text     cr buf)

  (cairo-destroy       cr)

  #f)

(define (time-handler win)
  (if (not win)
      #f
    (begin
      (set! buf (date->string (current-date) "~I:~M:~S"))

      (queue-draw win)

      #t)))

(define (timer)
  (let ([window (gtk-window-new 'toplevel)]
        [dArea  (gtk-drawing-area-new)])
    (add window dArea)

    (connect dArea  'expose-event on-expose-event)
    (connect window 'destroy      (lambda (w) (gtk-main-quit)))

    (set-position     window 'center)
    (set-default-size window 300 200)
    (set-title        window "Timer")

    (g-timeout-add 1000 (lambda () (time-handler window)))

    (show-all window)

    (time-handler window)))

(timer)
(gtk-main)
