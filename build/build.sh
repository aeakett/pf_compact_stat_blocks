#!/bin/bash

SOURCE_DOC=../stat_blocks.md
SOURCE_TEMP=stat_block.md
DIST_DIR=../dist/
HTM_FILE=stat_blocks.htm
HTM_TEMP=stat_blocks.htm
HTM_TARGET=$DIST_DIR$HTM_FILE
LATEX_FILE=stat_blocks.tex
LATEX_TEMP=stat_blocks.tex
LATEX_TARGET=$DIST_DIR$LATEX_FILE
MARKDOWN_BIN=~/bin/multimarkdown

CLOCK=$(python -c 'print u"\u0231a".encode("utf8")')
TARGET=$(python -c 'print u"\u02295".encode("utf8")')
HOURGLASS=$(python -c 'print u"\u0231B".encode("utf8")')
RULER=$(python -c 'print u"\u1F4CF".encode("utf8")')
FIRE=$(python -c 'print u"\u1F525".encode("utf8")')
ACID=$(python -c 'print u"\u1F4A7".encode("utf8")')
COLD=$(python -c 'print u"\u02744".encode("utf8")')
ELEC=$(python -c 'print u"\u026a1".encode("utf8")')
SONIC=$(python -c 'print u"\u02652".encode("utf8")')

cp spells.mmd $SOURCE_TEMP

# Do HTML & RTF
cp $SOURCE_DOC $SOURCE_TEMP
echo -e "\n* * *\n" >> $SOURCE_TEMP
cat ../license.md >> $SOURCE_TEMP
sed -i 's/x\([0-9]\)/\&times;\1/g' $SOURCE_TEMP
sed -i 's/\([0-9]\)"/\1\&Prime;/g' $SOURCE_TEMP
sed -i "s/\([0-9]\)'/\1\&prime;/g" $SOURCE_TEMP
sed -i 's/x\([0-9]\)/\&times;\1/g' $SOURCE_TEMP
sed -i 's/\([0-9]\)"/\1\&Prime;/g' $SOURCE_TEMP
sed -i "s/\([0-9]\)'/\1\&prime;/g" $SOURCE_TEMP
sed -i 's/\*\*Cast Time\*\*/\*\*Cast\*\* <span class="symbol">\&#8986;<\/span>/' $SOURCE_TEMP
sed -i 's/\*\*Target\*\*/<span class="symbol">**\&#8853;**<\/span>/' $SOURCE_TEMP
sed -i 's/\*\*Duration\*\*/<span class="symbol">**\&#8987;**<\/span>/' $SOURCE_TEMP
sed -i 's/\*\*Range\*\*/<span class="symbol">\&#128207;<\/span>/' $SOURCE_TEMP
sed -i 's/~~fire~~/<span class="symbol">\&#128293;<\/span>/' $SOURCE_TEMP
sed -i 's/~~acid~~/<span class="symbol">\&#128167;<\/span>/' $SOURCE_TEMP
sed -i 's/~~cold~~/<span class="symbol">\&#10052;<\/span>/' $SOURCE_TEMP
sed -i 's/~~elec~~/<span class="symbol">\&#9889;<\/span>/' $SOURCE_TEMP
sed -i 's/~~sonic~~/<span class="symbol">\&#9810;<\/span>/' $SOURCE_TEMP
echo '<!DOCTYPE html>\n   <head>\n      <meta charset="utf-8">\n      <title>Compact Pathfinder Stat Blocks</title>\n      <style>.symbol{font-family: "Segoe UI Symbol";}h6{display:block;font-size:1em;margin:0em;font-weight:bold;text-decoration:underline;}p{margin-top:0em;}</style>\n   </head>\n   <body>' > $HTM_TEMP
$MARKDOWN_BIN $SOURCE_TEMP >> $HTM_TEMP
echo '   </body>\n</html>' >> $HTM_TEMP
./htm2rtf.pl
mv stat_blocks.rtf $DIST_DIR
mv $HTM_TEMP $HTM_TARGET

# Do PDF
#cp $SOURCE_DOC $SOURCE_TEMP
#echo -e "\n- - -\n" >> $SOURCE_TEMP
#cat ../license.md >> $SOURCE_TEMP
##sed -i 's/x\([0-9]\)/\\times\1/g' $SOURCE_TEMP
#echo '\documentclass[11pt,letterpaper]{article}' > $LATEX_TEMP
#echo '\begin{document}' >> $LATEX_TEMP
#$MARKDOWN_BIN --to=latex $SOURCE_TEMP >> $LATEX_TEMP
#echo '' >> $LATEX_TEMP
#echo '\end{document}' >> $LATEX_TEMP
#sed -i 's/x\([0-9]\)/$\\times$\1/g' $LATEX_TEMP
#sed -i "s/\([0-9]\)'/\1$^{\\\prime}$/g" $LATEX_TEMP
#sed -i 's/\([0-9]\)"/\1$^{\\\prime\\\prime}$/g' $LATEX_TEMP
#latexmk $LATEX_TEMP
#makeglossaries $LATEX_TEMP
#pdflatex $LATEX_TEMP
#pdflatex $LATEX_TEMP
#latexmk -c $LATEX_TEMP
#mv stat_blocks.pdf $DIST_DIR 
#rm stat_blocks.dvi; rm $LATEX_TEMP
rm $SOURCE_TEMP
