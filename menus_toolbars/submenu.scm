(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define (submenu)
  (let ([window   (make <gtk-window> #:type 'toplevel)]
        [vbox     (make <gtk-vbox>   #:homogeneous #f #:spacing 0)]
        [menubar  (make <gtk-menu-bar>)]
        [fileMenu (make <gtk-menu>)]
        [imprMenu (make <gtk-menu>)]
        [sep      (make <gtk-separator-tool-item>)]
        [fileMi   (make <gtk-menu-item> #:label "File")]
        [imprMi   (make <gtk-menu-item> #:label "Import")]
        [feedMi   (make <gtk-menu-item> #:label "Import news feed…")]
        [bookMi   (make <gtk-menu-item> #:label "Import bookmarks…")]
        [mailMi   (make <gtk-menu-item> #:label "Import mail…")]
        [quitMi   (make <gtk-menu-item> #:label "Quit")])
    (set-title        window "Submenu")
    (set-default-size window 300 200)
    (set-position     window 'center)

    (add window vbox)

    (set-submenu imprMi imprMenu)
    (gtk-menu-shell-append imprMenu feedMi)
    (gtk-menu-shell-append imprMenu bookMi)
    (gtk-menu-shell-append imprMenu mailMi)

    (set-submenu fileMi fileMenu)
    (gtk-menu-shell-append fileMenu imprMi)
    (gtk-menu-shell-append fileMenu sep)
    (gtk-menu-shell-append fileMenu quitMi)
    (gtk-menu-shell-append menubar  fileMi)
    (pack-start vbox menubar #f #f 0)

    (connect window 'destroy  (lambda (w) (gtk-main-quit)))
    (connect quitMi 'activate (lambda (w) (gtk-main-quit)))

    (show-all window)))

(submenu)
(gtk-main)
