(define (script-fu-outline-bubble img drawable linewidth fillcolor outlinecolor)
    (let* (
        (bubble-layer (car (gimp-layer-new img 10 10 RGBA-IMAGE "Speech Bubble" 100 NORMAL-MODE)))
        (bubble-group (car (gimp-layer-group-new img)))
        (active-vectors (car (gimp-image-get-active-vectors img)))
      )
      (gimp-image-insert-layer img bubble-layer 0 0)
      (gimp-layer-resize-to-image-size bubble-layer)
      (gimp-context-set-foreground outlinecolor)
      (gimp-image-select-item img CHANNEL-OP-REPLACE active-vectors)
      (gimp-selection-grow img linewidth)
      (gimp-edit-fill bubble-layer FOREGROUND-FILL)
      (gimp-context-set-foreground fillcolor)
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
    "script-fu-outline-bubble"
    "Fill Outline Bubble. . ."
    "Turns a path into a normal speech bubble."
    "Sam Jones"
    "copyright 2017, Sam Jones"
    "August 20, 2017"
    ""
    SF-IMAGE         "Image"        0
    SF-DRAWABLE      "Text to Box"  0
    SF-ADJUSTMENT    "Line Width"     '(6 1 20 1 5 0 SF-SLIDER)
    SF-COLOR         "Fill Color"   '(255 255 255)
    SF-COLOR         "Outline Color" '(0 0 0)
)

(script-fu-menu-register "script-fu-outline-bubble" "<Image>/Filters/Speech")
