#!/bin/bash

SOURCE_DOC=../stat_blocks.md
SOURCE_TEMP=stat_block.md
HTM_TARGET=stat_blocks.htm
LATEX_TARGET=stat_blocks.tex
MARKDOWN_BIN=~/bin/multimarkdown

cp $SOURCE_DOC $SOURCE_TEMP
sed -i 's/x\([0-9]\)/\&times;\1/g' $SOURCE_TEMP
sed -i 's/\([0-9]\)"/\1\&Prime;/g' $SOURCE_TEMP
sed -i "s/\([0-9]\)'/\1\&prime;/g" $SOURCE_TEMP
echo '<!DOCTYPE html>\n   <head>\n      <meta charset="utf-8">\n      <title>Compact Pathfinder Stat Blocks</title>\n      <style>h6{display:block;font-size:1em;margin:0em;font-weight:bold;text-decoration:underline;}p{margin-top:0em;}</style>\n   </head>\n   <body>' > $HTM_TARGET
$MARKDOWN_BIN $SOURCE_TEMP >> $HTM_TARGET
echo '   </body>\n</html>' >> $HTM_TARGET

cp $SOURCE_DOC $SOURCE_TEMP
#sed -i 's/x\([0-9]\)/\\times\1/g' $SOURCE_TEMP
echo '\\documentclass[11pt,letterpaper]{article}\n\\begin{document}\n' > $LATEX_TARGET
$MARKDOWN_BIN --to=latex $SOURCE_TEMP >> $LATEX_TARGET
echo '\n\\end{document}' >> $LATEX_TARGET
sed -i 's/x\([0-9]\)/$\\times$\1/g' $LATEX_TARGET
sed -i "s/\([0-9]\)'/\1$^{\\\prime}$/g" $LATEX_TARGET
sed -i 's/\([0-9]\)"/\1$^{\\\prime\\\prime}$/g' $LATEX_TARGET
latexmk $LATEX_TARGET
makeglossaries $LATEX_TARGET
pdflatex $LATEX_TARGET
pdflatex $LATEX_TARGET
latexmk -c $LATEX_TARGET
#rm statblock.dvi; rm $LATEX_TARGET
rm $SOURCE_TEMP
