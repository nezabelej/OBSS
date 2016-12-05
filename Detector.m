%Call: Detector('input/100')
function Detector(record)
  fileName = sprintf('%sm.mat', record);
  t = cputime();
  
  M = 5;    % filter length
  WS = 30;  % sliding window size
  idx = QRSDetect(fileName, M, WS)
  
  fprintf('Running time: %f\n', cputime() - t);
  asciName = sprintf('%s.asc',record);
  fid = fopen(asciName, 'wt');
  for i=1:size(idx,2)
      fprintf(fid,'0:00:00.00 %d N 0 0 0\n', idx(1,i) );
  end
  fclose(fid);
end
