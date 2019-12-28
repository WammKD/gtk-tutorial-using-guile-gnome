(use-modules (gi) (gi repository) (gi types))

(require "Gio" "2.0")
(require "Gtk" "3.0")

(load-by-name "Gtk" "AboutDialog")
(load-by-name "Gio" "Application") ;; activate, run
(load-by-name "Gtk" "Application")
(load-by-name "Gtk" "ApplicationWindow")
(load-by-name "Gtk" "WindowPosition")

;; I'm not sure if the <GdkPixbuf> has been implimented, yet, in Guile-GI
;; (leastwise, I haven't been able to find it)
