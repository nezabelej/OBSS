#!/bin/bash
for f in /home/neza/mitdb/*.dat
do
  cd /home/neza/mitdb;
  wfdb2mat -r $(basename "$f" .dat);
done
