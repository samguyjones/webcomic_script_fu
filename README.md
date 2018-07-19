# webcomic_script_fu
A bunch of GIMP scripts that are handy in making a webcomic.

These are a bunch of scripts I made for GIMP that made it a little easier for me to
draw a webcomic.  To use the scripts, just download GIMP (available at
https://www.gimp.org/downloads/) and copy the scm files into the script folder.  To
find the script folder, open GIMP and select Edit->Preferences->Folders->Scripts.

The scripts will then appear either the next time you start GIMP or after you pick
Filters->Script Fu->Refresh Scripts in GIMP.

Here's what I have so far:

## Make Speech Bubble Path
This will appear in the GIMP menu under Filters->Speech->Make Speech Bubble Path.
Before you run this script, make sure you have the text of the speech bubble selected.
The selected layer doesn't have to be text, but it has to be smaller than the overall page.

This script will have two arguments.  One is roundness and one is distance.  Both, I'm
afraid, are measures that don't make sense.  Here's a rough idea:  300 is a oval and 10
is a rectangle with a slight rounding of the corners.  A distance of 10 will almost
touch your layer and 250 will generate padding about 10% as wide as your contained layer.

The speech bubble it creates is a path.  You can use path editing tools to add a tail to
show who's talking.  Or, if you want an oval/rectanglish bubble on its own, you can use
one of the bubble drawing tools right away.

## Fill Outline Bubble
This script will appear under Filters->Speech->Fill Outline Bubble.  Before you run this
script, make sure that you have a speech bubble path selected (the script above will draw
that path) and make sure you have the layer with the speech bubble contents selected.  The
script has three parameters:  the color of the inside of the bubble, the color of the outline
of the bubble and the width of the outline.

After you hit "Ok", a new layer group will be created.  This group will contain your contents
and a speech bubble.

## Fill Solid Bubble
This script is under Filters->Speech->Fill Solid Bubble.  It works like outline bubble above.
It takes only one parameter for the bubble color.  It'll make a layer group with your text and
the new bubble.

## Export Panel
This script exists mostly as an example.  It has values hard-coded for my filesystem.  It will
take the current image, make a duplicate of it and export it to a specific path.  You need to
edit the panel-export.scm to use it.

## Mass Export
This script does not require editing, but it's meant to be used on the command line.  The command
is like this:

gimp -i -b '(mass-panel-export *source file* *export width* *export width/height ratio* *destination directory*)' -b (gimp-quit 0)'

Okay, that's a lot of parameters.  Here's a rundown:
 * source file is the name of a GIMP file that you want to export to PDF.  You can use wildcards
   to export many files at once.
 * export width is the width in pixels of the file you want to export.  The exported file will have
   the source name plus a "-" plus the number of pixels in width and then ".png".  You can have
   a comma separated list for export width.  If you do, the script will export each source image
   multiple times -- once for each width.
 * export width/height ratio - A number for the width over the height.  My webcomic is always 1200x1600, so my
   ratio is .75.
 * Destination directory - This is where all the exported files will go.
 
