(use-modules (gnome-2) (oop goops) (gnome gobject) (gnome gtk))

(define (images-mnemonics-accelerators)
  (let* ([window     (gtk-window-new 'toplevel)]
         [vbox       (gtk-vbox-new #f 0)]
         [menubar    (gtk-menu-bar-new)]
         [fileMenu   (gtk-menu-new)]
         [fileMi     (gtk-menu-item-new-with-mnemonic "_File")]
         [ newMi     (gtk-image-menu-item-new-from-stock (gtk-stock-id 'new)  (gtk-accel-group-new))]
         [openMi     (gtk-image-menu-item-new-from-stock (gtk-stock-id 'open) (gtk-accel-group-new))]
         [sep        (gtk-separator-menu-item-new)]
         [accelGroup (gtk-accel-group-new)]
         [quitMi     (gtk-image-menu-item-new-from-stock (gtk-stock-id 'quit) accelGroup)])
    (set-title        window "Images")
    (set-default-size window 300 200)
    (set-position     window 'center)

    (add window vbox)

    (add-accel-group window accelGroup)

    (add-accelerator
      quitMi
      "activate"
      accelGroup
      (gdk-keyval-from-name "q")
      (make <gdk-modifier-type> #:value 'control-mask) ;https://code.woboq.org/gtk/gtk/gdk/gdktypes.h.html#GDK_CONTROL_MASK
      (make <gtk-accel-flags>   #:value 'visible))     ;https://lazka.github.io/pgi-docs/Gtk-3.0/flags.html#Gtk.AccelFlags

    (set-submenu fileMi fileMenu)
    (gtk-menu-shell-append fileMenu newMi)
    (gtk-menu-shell-append fileMenu openMi)
    (gtk-menu-shell-append fileMenu sep)
    (gtk-menu-shell-append fileMenu quitMi)
    (gtk-menu-shell-append menubar fileMi)
    (pack-start vbox menubar #f #f 0)

    (connect window 'destroy  (lambda (w) (gtk-main-quit)))
    (connect quitMi 'activate (lambda (w) (gtk-main-quit)))

    (show-all window)))

(images-mnemonics-accelerators)
(gtk-main)
