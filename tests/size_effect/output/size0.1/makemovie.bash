#!/bin/bash

#for x in eps/*.eps; do 
#    echo $x
#    convert -density 300 eps/$x jpg/$x.jpg
#done

#convert -density 100 eps/*.eps jpg/%05d.jpg
#convert tmp/*.jpg -delay 2 -morph 2 tmp/%05d.morph.jpg

ffmpeg -r 25 -qscale 2 -i euler_length_%05d.jpg movie.mp4 
#rm -rfv tmp
