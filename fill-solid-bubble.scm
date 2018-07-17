(define (script-fu-fill-bubble img drawable fillcolor)
    (gimp-context-set-foreground fillcolor)
    (let* (
        (bubble-layer (car (gimp-layer-new img 10 10 RGBA-IMAGE "Speech Bubble" 100 NORMAL-MODE)))
        (bubble-group (car (gimp-layer-group-new img)))
        (active-vectors (car (gimp-image-get-active-vectors img)))
      )
      (gimp-image-insert-layer img bubble-layer 0 0)
      (gimp-layer-resize-to-image-size bubble-layer)
      (gimp-image-select-item img CHANNEL-OP-REPLACE active-vectors)
      (gimp-edit-fill bubble-layer FOREGROUND-FILL)
      (gimp-selection-none img)
      (gimp-layer-set-opacity bubble-group 100)
      (gimp-layer-set-mode bubble-group NORMAL-MODE)
      (gimp-image-insert-layer img bubble-group 0 0)
      (gimp-image-reorder-item img bubble-layer bubble-group 0)
      (gimp-image-reorder-item img drawable bubble-group 0)
      (plug-in-autocrop-layer 1 img bubble-layer)
    )
    (gimp-displays-flush)
)

(script-fu-register
    "script-fu-fill-bubble"
    "Fill Solid Bubble. . ."
    "Turns a path into a solid speech bubble."
    "Sam Jones"
    "copyright 2017, Sam Jones"
    "August 20, 2017"
    ""
    SF-IMAGE         "Image"        0
    SF-DRAWABLE      "Text to Box"  0
    SF-COLOR         "Fill Color"   '(0 0 0)
)

(script-fu-menu-register "script-fu-fill-bubble" "<Image>/Filters/Speech")
