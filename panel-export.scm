(define (script-fu-panel-export inImg drawable inWidth)
    (define filename (car(gimp-image-get-filename inImg)))
    (define comHeight (/ inWidth .75))
    (define piece (car(cdr(cdr(cdr(cdr(cdr(strbreakup filename "/"))))))))
    (define base (car(strbreakup piece ".")))
    (define destination (string-append "/home/samjones/Dev/mobinge/lib/images/" base "-" (number->string inWidth) ".png"))
    (let* ((duplicateImg (car(gimp-image-duplicate inImg))))
        (gimp-image-scale duplicateImg inWidth comHeight)
        (gimp-image-flatten duplicateImg)
        (file-png-save 1 duplicateImg (car(gimp-image-get-active-drawable duplicateImg))_destination destination 1 0 0 0 0 0 0)
        (gimp-image-delete duplicateImg)
    )
)

(script-fu-register
    "script-fu-panel-export"
    "Export Panel. . ."
    "Creates a flattened image export to a selected size.."
    "Sam Jones"
    "copyright 2017, Sam Jones"
    "December 19, 2017"
    ""
    SF-IMAGE         "Image"        0
    SF-DRAWABLE      "Maybe unused" 0
    SF-ADJUSTMENT    "Width"        '(320 20 1200 10 50 0 SF-SLIDER)
)

(script-fu-menu-register "script-fu-panel-export" "<Image>/Filters")
