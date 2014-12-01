#!/bin/bash -x

FIRM="$1";
NEWFIRM="firm";

mkdir $NEWFIRM;
dd if=$1 bs=1 count=64 of=$NEWFIRM/header;

OFFSET=`binwalk $FIRM |awk '$0!~"0x80|0x40"&&$0~"gzip"{print $1}'`;
let COUNT=$OFFSET-64;

dd if=$1 bs=1 count=$COUNT skip=64 of=$NEWFIRM/part1;
dd if=$1 bs=1 skip=$OFFSET of=$NEWFIRM/part2;
mkdir $NEWFIRM/temp;

tar xzf $NEWFIRM/part2 -C $NEWFIRM/temp;

