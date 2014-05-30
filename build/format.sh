#!/bin/bash

SOURCE_TEMP=stat_block.md
HTM_FILE=stat_blocks.htm
HTM_TEMP=stat_blocks.htm
HTM_TARGET=$DIST_DIR$HTM_FILE
MARKDOWN_BIN=~/bin/multimarkdown.exe

CLOCK=$(python -c 'print u"\u0231a".encode("utf8")')
TARGET=$(python -c 'print u"\u02295".encode("utf8")')
HOURGLASS=$(python -c 'print u"\u0231B".encode("utf8")')
RULER=$(python -c 'print u"\u1F4CF".encode("utf8")')
FIRE=$(python -c 'print u"\u1F525".encode("utf8")')
ACID=$(python -c 'print u"\u1F4A7".encode("utf8")')
COLD=$(python -c 'print u"\u02744".encode("utf8")')
ELEC=$(python -c 'print u"\u026a1".encode("utf8")')
SONIC=$(python -c 'print u"\u02652".encode("utf8")')


# Do HTML & RTF
cp $1 $SOURCE_TEMP
echo -e "\n* * *\n" >> $SOURCE_TEMP
sed -i 's/x\([0-9]\)/\&times;\1/g' $SOURCE_TEMP
sed -i 's/\([0-9]\)"/\1\&Prime;/g' $SOURCE_TEMP
sed -i "s/\([0-9]\)'/\1\&prime;/g" $SOURCE_TEMP
sed -i 's/x\([0-9]\)/\&times;\1/g' $SOURCE_TEMP
sed -i 's/\([0-9]\)"/\1\&Prime;/g' $SOURCE_TEMP
sed -i "s/\([0-9]\)'/\1\&prime;/g" $SOURCE_TEMP
sed -i 's/<=/\&le;/g' $SOURCE_TEMP
sed -i 's/>=/\&ge;/g' $SOURCE_TEMP
sed -i 's/\*\*Cast Time\*\*/\*\*Cast\*\* <span class="symbol">\&#8986;<\/span>/' $SOURCE_TEMP
sed -i 's/\*\*Target\*\*/<span class="symbol">**\&#8853;**<\/span>/' $SOURCE_TEMP
sed -i 's/\*\*Duration\*\*/<span class="symbol">**\&#8987;**<\/span>/' $SOURCE_TEMP
sed -i 's/\*\*Range\*\*/<span class="symbol">\&#128207;<\/span>/' $SOURCE_TEMP
sed -i 's/~~fire~~/<span class="symbol">\&#128293;<\/span>/g' $SOURCE_TEMP
sed -i 's/~~acid~~/<span class="symbol">\&#128167;<\/span>/g' $SOURCE_TEMP
sed -i 's/~~cold~~/<span class="symbol">\&#10052;<\/span>/g' $SOURCE_TEMP
sed -i 's/~~elec~~/<span class="symbol">\&#9889;<\/span>/g' $SOURCE_TEMP
sed -i 's/~~sonic~~/<span class="symbol">\&#9810;<\/span>/g' $SOURCE_TEMP
sed -i 's/\*\*ac\*\*/<span class="symbol">\&#9960;<\/span>/g' $SOURCE_TEMP
sed -i 's/\*\*hp\*\*/<span class="symbol">\&#9829;<\/span>/g' $SOURCE_TEMP
sed -i 's/->/\&rarr;/g' $SOURCE_TEMP
echo '<!DOCTYPE html><head><meta charset="utf-8"><title>Compact Pathfinder Stat Blocks</title><style>body{font-size:9pt;}.symbol{font-family: "Segoe UI Symbol",Symbola;}h2{display:block;font-size:1em;margin:0em;font-weight:bold;text-decoration:underline;}p{margin-top:0em;}blockquote(margin-top:0em;margin-bottom:0em;}</style></head><body>' > $HTM_TEMP
$MARKDOWN_BIN $SOURCE_TEMP >> $HTM_TEMP
echo '</body></html>' >> $HTM_TEMP
#./htm2rtf.pl