(define (script-fu-speech-bubble img drawable inRoundness inSpace)
    (gimp-context-set-foreground '(0 0 0))
    (define bubble-layer (car (gimp-layer-copy drawable 0)))
    (gimp-image-insert-layer img bubble-layer 0 0)
    (gimp-selection-all img)
    (gimp-edit-fill bubble-layer FOREGROUND-FILL)
    (define white-layer (car (gimp-layer-new img 50 50 RGB-IMAGE "speech bubble"
        100 NORMAL-MODE)))
    (gimp-image-insert-layer img white-layer 0 1)
    (gimp-layer-resize-to-image-size white-layer)
    (gimp-edit-fill white-layer BACKGROUND-FILL)
    (define bubble-layer (car (gimp-image-merge-down img bubble-layer EXPAND-AS-NECESSARY)))
    (plug-in-gauss RUN-NONINTERACTIVE img bubble-layer inRoundness inRoundness 0)
    (gimp-levels bubble-layer HISTOGRAM-VALUE inSpace 255 .1 0 255)
    (gimp-image-select-color img CHANNEL-OP-REPLACE bubble-layer '(0 0 0))
    (plug-in-sel2path RUN-NONINTERACTIVE img bubble-layer)
    (gimp-selection-none img)
    (gimp-image-remove-layer img bubble-layer)
)

(script-fu-register
    "script-fu-speech-bubble"
    "Make Speech Bubble Path. . ."
    "Creates a path for a speech bubble as a path \
     around a text layer.  It has an adjustable \
     distance from the text and roundness."
    "Sam Jones"
    "copyright 2017, Sam Jones"
    "August 20, 2017"
    ""
    SF-IMAGE         "Image"        0
    SF-DRAWABLE      "Text to Box"  0
    SF-ADJUSTMENT    "Roundness"    '(50 10 300 10 50 0 SF-SLIDER)
    SF-ADJUSTMENT    "Distance"     '(140 10 250 10 40 0 SF-SLIDER)
)

(script-fu-menu-register "script-fu-speech-bubble" "<Image>/Filters/Speech")
