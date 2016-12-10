%Call: Detector('100')
function Detector(record)
  fileName = sprintf('input/%sm.mat', record);
  t = cputime();
  
  M = 5;    % filter length
  WS = 10;  % sliding window size
  WSDecision = 180; 
  idx = QRSDetect(fileName, M, WS, WSDecision);
  
  fprintf('Running time: %f\n', cputime() - t);
  asciName = sprintf('det/%s.det', record);
  fid = fopen(asciName, 'wt');
  for i=1:size(idx, 2)
      fprintf(fid,'0:00:00.00 %d N 0 0 0\n', idx(1, i) );
  end
  fclose(fid);
end
