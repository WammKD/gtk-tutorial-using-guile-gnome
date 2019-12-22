(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define (toggle-statusbar togstat statusbar)
  (if (get-active togstat) (show statusbar) (hide statusbar)))

(define (check-menuitem)
  (let ([window    (gtk-window-new 'toplevel)]
        [vbox      (gtk-vbox-new #f 0)]
        [menubar   (gtk-menu-bar-new)]
        [viewMenu  (gtk-menu-new)]
        [view      (gtk-menu-item-new-with-label "View")]
        [togStat   (gtk-check-menu-item-new-with-label "View statusbar")]
        [statusbar (gtk-statusbar-new)])
    (set-title        window "GtkCheckMenuItem")
    (set-default-size window 300 200)
    (set-position     window 'center)

    (add window vbox)

    (set-active togStat #t)

    (set-submenu view viewMenu)
    (gtk-menu-shell-append viewMenu togStat)
    (gtk-menu-shell-append menubar  view)
    (pack-start vbox menubar   #f #f 0)
    (pack-end   vbox statusbar #f #t 0)

    (connect window  'destroy  (lambda (w) (gtk-main-quit)))
    (connect togStat 'activate (lambda (w) (toggle-statusbar togStat statusbar)))
    ;; It may just be because there's nothing in the statusbar and things have
    ;; changed to GTK but it's not visible, which makes hiding it not
    ;; as…informative. Use this one to hide the menubar, instead.
    ;; You won't be able to make it visible, again (since the view menu item is
    ;; a member of the menubar and gets hidden, as well), but it'll, at least,
    ;; demonstrate that it works.
    ;; (connect togStat 'activate (lambda (w) (toggle-statusbar togStat statusbar)))

    (show-all window)))

(check-menuitem)
(gtk-main)
