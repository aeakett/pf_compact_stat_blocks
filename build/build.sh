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

# Do HTML & RTF
cp $SOURCE_DOC $SOURCE_TEMP
echo -e "\n* * *\n" >> $SOURCE_TEMP
cat ../license.md >> $SOURCE_TEMP
sed -i 's/x\([0-9]\)/\&times;\1/g' $SOURCE_TEMP
sed -i 's/\([0-9]\)"/\1\&Prime;/g' $SOURCE_TEMP
sed -i "s/\([0-9]\)'/\1\&prime;/g" $SOURCE_TEMP
echo '<!DOCTYPE html>\n   <head>\n      <meta charset="utf-8">\n      <title>Compact Pathfinder Stat Blocks</title>\n      <style>h6{display:block;font-size:1em;margin:0em;font-weight:bold;text-decoration:underline;}p{margin-top:0em;}</style>\n   </head>\n   <body>' > $HTM_TEMP
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
