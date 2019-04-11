(in-package :cl-logo.backend.sdl2)

(defparameter *draw-commands* nil)

(defclass sdl2-backend (transaction)
  ((width :initarg :width
          :accessor width)
   (height :initarg :height
           :accessor height)
   (fps :initarg :fps
        :initform 60
        :accessor fps)))

(defmethod print-object ((object sdl2-backend) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (with-slots (width height fps) object
      (format stream ":width ~d :height ~d :fps ~d" width height fps))))

(defmethod init ((backend sdl2-backend))
  (bt:make-thread (lambda ()
                    (sdl2:make-this-thread-main (lambda ()
                                                  (funcall #'run-loop backend))))))

(defmethod shutdown ((backend sdl2-backend))
  (sdl2:push-event :quit)
  (values))

(defmethod update ((backend sdl2-backend))
  (when sdl2::*event-loop*
    (sdl2:push-event :userevent)))

(defmethod draw-line ((backend sdl2-backend) x1 y1 x2 y2)
  (unless (/= (transaction-count backend) 0)
    (error "draw-line should be called in a transaction"))

  (setf (transaction-commands backend)
        (cons (lambda ()
                (cairo:move-to x1 y1)
                (cairo:line-to x2 y2))
              (transaction-commands backend)))

  (format t "SDL2: draw line from (~D, ~D) to (~D, ~D)~%" x1 y1 x2 y2))

(defmethod reset-backend ((backend sdl2-backend))
  (setf *draw-commands* nil)
  (update backend))

(defun set-sdl2-backend-as-default (&key width height)
  (setf *backend* (make-instance 'sdl2-backend :width width :height height)))

(defmethod start-transaction ((backend sdl2-backend))
  (call-next-method)
  (format t "start-transaction SDL2 ~A~%" (transaction-count backend)))

(defmethod end-transaction ((backend sdl2-backend))
  (format t "end-transaction SDL2 ~A~%" (transaction-count backend))

  (when (= (transaction-count backend) 1)
    (setf *draw-commands*
          (cons (reverse (transaction-commands backend))
                *draw-commands*))
    (setf (transaction-commands backend) nil))

  (call-next-method)

  (update backend))

(defun run-commands (cmds)
  (cond ((null cmds) nil)
        ((functionp cmds) (funcall cmds))
        ((consp cmds)
         (run-commands (car cmds))
         (run-commands (cdr cmds)))
        (t (error "cl-logo.backend.sdl2:run-commands expects FUNCTION or LIST but got ~A~%"
                  (type-of cmds)))))

(defparameter *vertex-shader* "
varying vec2 texture_coordinate;
void main() {
    texture_coordinate = vec2(gl_MultiTexCoord0);
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
")

(defparameter *fragment-shader* "
#version 120
varying vec2 texture_coordinate;
uniform sampler2D tex;
void main() {
    gl_FragColor = texture2D(tex, texture_coordinate);
}
")

(defun gl-ortho-setup (&key (width 500) (height 500))
  "Set up 1:1 pixel ortho matrix with origin bottom left of the screen"
  (gl:viewport 0 0 width height)
  (gl:matrix-mode :projection)
  (gl:ortho 0 ;; left
            width ;; right
            0 ;; bottom
            height ;; top
            -1 ;; near
            1)) ;; far

(defun compile-and-check-shader (shader source)
  (gl:shader-source shader source)
  (gl:compile-shader shader)
  (unless (gl:get-shader shader :compile-status)
    (gl:get-shader-info-log shader)))

(defun gl-init-shaders ()
  (let ((v-shader (gl:create-shader :vertex-shader))
        (f-shader (gl:create-shader :fragment-shader)))
    (compile-and-check-shader v-shader *vertex-shader*)
    (compile-and-check-shader f-shader *fragment-shader*)
    (let ((program (gl:create-program)))
      (if (zerop program)
          (error "Error creating program")
          (progn
            (gl:attach-shader program v-shader)
            (gl:attach-shader program f-shader)
            (gl:link-program program)
            (format t "~A~%" (gl:get-program-info-log program))
            (gl:use-program program)))
      program)))

(defun draw-quad (&key width height)
  (gl:with-primitives :quads
    (gl:color 1.0 0.0 0.0 1.0)

    (gl:tex-coord 0.0 0.0)
    (gl:vertex 0.0 0.0)

    (gl:tex-coord 0.0 1.0)
    (gl:vertex 0.0 height)

    (gl:tex-coord 1.0 1.0)
    (gl:vertex width height)

    (gl:tex-coord 1.0 0.0)
    (gl:vertex width 0.0))
  )

(defun render (window width height tex texname)
  (let* ((surf (cairo:create-image-surface-for-data
                tex :argb32 width height (* 4 width)))
         (ctx (cairo:create-context surf)))
    (cairo:with-context (ctx)
      (cairo:set-source-rgb 0 0 0)
      (cairo:paint)
      (cairo:set-source-rgb 1 1 1)
      (cairo:set-line-width 1)
      ;; (cairo:move-to 0 0)
      ;; (cairo:line-to width height)
      (run-commands *draw-commands*)
      (cairo:stroke))
    (cairo:destroy ctx)
    (cairo:destroy surf))
  (gl:bind-texture :texture-2d texname)
  (gl:tex-sub-image-2d :texture-2d 0 0 0 width height :bgra :unsigned-byte tex)
  (draw-quad :width width :height height)
  (gl:flush)
  (sdl2:gl-swap-window window))

(defun run-loop (backend)
  (let ((width (width backend))
        (height (height backend))
        (delay (floor (float (/ 1000 60)))))
    (sdl2:with-init (:everything)
      (multiple-value-bind (window renderer)
          (sdl2:create-window-and-renderer width height '(:shown :opengl))
        (sdl2:with-gl-context (gl window)
          (sdl2:gl-make-current window gl)
          (gl:enable :texture-2d)
          (gl-ortho-setup :width width :height height)
          (autowrap:with-alloc (tex :unsigned-char (* width height 4))
            (let* ((program (gl-init-shaders))
                   (texname (car (gl:gen-textures 1)))
                   (texid (gl:get-uniform-location program "tex")))
              (gl:active-texture :texture0)
              (gl:bind-texture :texture-2d texname)
              (gl:uniformi texid 0)
              (gl:tex-parameter :texture-2d :texture-wrap-s :repeat)
              (gl:tex-parameter :texture-2d :texture-wrap-t :repeat)
              (gl:tex-parameter :texture-2d :texture-min-filter :nearest)
              (gl:tex-parameter :texture-2d :texture-mag-filter :nearest)
              ;; Give it to opengl right away so we can use the faster tex-sub-image later. Also, the
              ;; actual internal format is bgra, so it matches what SDL is going to say about the
              ;; surface we're going to create.
              (gl:tex-image-2d :texture-2d ;; target
                               0 ;; level
                               :rgba ;; internal format
                               width ;; width
                               height ;; height
                               0 ;; border
                               :bgra ;; format
                               :unsigned-byte ;; type
                               tex) ;; data
              (gl:matrix-mode :modelview)
              (gl:load-identity)
              (gl:clear-color 0.0 0.0 0.0 1.0)
              (gl:clear :color-buffer)

              (render window width height tex texname)

              (sdl2:with-event-loop (:method :poll)
                (:quit () t)
                (:keyup (:keysym keysym)
                        (when (sdl2:scancode= (sdl2:scancode-value keysym)
                                              :scancode-escape)
                          (sdl2:push-event :quit)))
                (:userevent ()
                            (render window width height tex texname))
                (:idle ()
                       (sdl2:delay delay)))

              (sdl2:destroy-renderer renderer)
              (sdl2:destroy-window window))))))))

(eval-when (::load-toplevel)
  (set-sdl2-backend-as-default :width 512 :height 512))
