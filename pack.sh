#!/bin/bash -x

FIRM="$1";
NEWFIRM="firm";

cd $NEWFIRM/temp/;
tar czf ../part2.new *
cd ../;

PART1=`ls -la | awk '$0~"part1"{print $5}'`;
PART2=`ls -la | awk '$0~"part2.new"{print $5}'`;
let SIZE=$PART1+$PART2;
HEXSIZE=`echo -n $SIZE | awk '{printf ("%08x",$0)}'`;
echo $HEXSIZE;
echo -n $HEXSIZE | xxd -r -p >newheader;
tail -c60 header >>newheader;

cat newheader > ../new.img;
cat part1 >> ../new.img;
cat part2.new >> ../new.img;
