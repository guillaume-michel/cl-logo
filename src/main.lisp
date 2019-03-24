;;;; main.lisp

(in-package #:cl-logo)

(defparameter *screen-width* 320)
(defparameter *screen-height* 240)

(defmacro with-window-surface ((window surface) &body body)
  `(sdl2:with-init (:video)
     (sdl2:with-window (,window
                        :title "SDL2 Tutorial"
                        :w *screen-width*
                        :h *screen-height*
                        :flags '(:shown))
       (let ((,surface (sdl2:get-window-surface ,window)))
         ,@body))))


(defun main-loop()
  (with-window-surface (window screen-surface)
    (sdl2:with-event-loop (:method :poll)
      (:quit () t)
      (:keyup (:keysym keysym)
             (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
               (sdl2:push-event :quit)))
      (:idle ()
             (sdl2:fill-rect screen-surface
                             nil
                             (sdl2:map-rgb (sdl2:surface-format screen-surface) 255 255 255))
             (sdl2:update-window window)
             (sdl2:delay 100)))))

(defun main ()
  ; making other thread main for sdl
  (bt:make-thread (lambda ()
                    (sdl2:make-this-thread-main #'main-loop))))
