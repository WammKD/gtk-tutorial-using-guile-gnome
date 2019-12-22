(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk) (gnome gtk gdk-event))

(define (show-popup menu event)
  (define RIGHT_CLICK 3)

  (if (eq? (gdk-event:type event) 'button-press)
      (begin
        (when (eq? (gdk-event-button:button event) RIGHT_CLICK)
          (gtk-menu-popup
            menu #f                              #f
            #f   (gdk-event-button:button event) (gdk-event-button:time event)))

        #t)
    #f))

(define (popup)
  (let ([window (gtk-window-new 'toplevel)]
        [ebox   (gtk-event-box-new)]
        [pmenu  (gtk-menu-new)]
        [hideMi (gtk-menu-item-new-with-label "Minimize")]
        [quitMi (gtk-menu-item-new-with-label "Quit")])
    (set-title        window "Popup menu")
    (set-default-size window 300 200)
    (set-position     window 'center)


    (add window ebox)


    (show hideMi)
    (gtk-menu-shell-append pmenu hideMi)
    (connect hideMi 'activate (lambda (hMi) (gtk-window-iconify window)))

    (show quitMi)
    (gtk-menu-shell-append pmenu quitMi)
    (connect quitMi 'activate (lambda (qMi) (gtk-main-quit)))


    (connect ebox   'button-press-event (lambda (eBox ev) (show-popup
                                                            pmenu
                                                            ev)))
    (connect window 'destroy            (lambda (w)       (gtk-main-quit)))

    (show-all window)))

(popup)
(gtk-main)

