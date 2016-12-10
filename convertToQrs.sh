#!/bin/bash
for f in det/*.det
do
  cd /home/neza/det;
  cp /home/neza/mitdb/*.hea /home/neza/det;
  wrann -r $(basename "$f" .det) -a qrs < $(basename "$f");
done
