
(define (mass-panel-export pattern widthParam ratio destination)
 (let* ((filelist (cadr (file-glob pattern 1))))
   (while (not (null? filelist))
     (let* ((filename (car filelist))
       (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
     )
     (let* ((widthSet (strbreakup widthParam ",")))
       (while (not (null? widthSet))
         (let* ((width (string->number (car widthSet))))
           (let* ((duplicateImg (car(gimp-image-duplicate image))))
               (let* ((height (/ width ratio)))
                 (gimp-image-scale duplicateImg width height)
               )
               (gimp-image-flatten duplicateImg)
               (let* ((base (car(strbreakup filename "."))))
                 (let* ((destination (string-append destination "/" base "-"
                   (number->string width) ".png")))
                   (file-png-save 1 duplicateImg
                     (car(gimp-image-get-active-drawable duplicateImg))
                     destination destination 1 0 0 0 0 0 0)
                 )
               )
               (gimp-image-delete duplicateImg)
             )
           )
           (set! widthSet (cdr widthSet))
         )
       )
     (gimp-image-delete image))
     (set! filelist (cdr filelist))
    )
  )
)
