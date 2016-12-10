#!/bin/bash

for f in det/*.qrs
do
  cd /home/neza/det;
  cp /home/neza/mitdb/*.atr /home/neza/det;
  bxb -r $(basename "$f" .qrs) -a atr qrs -l eval1.txt eval2.txt;
done

sumstats eval1.txt eval2.txt > results.txt
