function indices = QRSDetect(filename, M, WS, WSDecision)

  signal = load(filename);
  x = signal.val(1,:);

  %Initial plotting.
  figure(1);
  xPlot = x(1:(size(x,2)/300));
  plot(xPlot);

  %1. High-pass filter
  y = zeros(1, size(x,2));
  for i=1:size(x,2)
    if (i >= M)   %In the line beneath, we do "i-M" and we do not want negative array indices.
      y1   = (1/M) * sum(x((i - (M - 1)) : i));
      y2   = x(i - ((M + 1)/2));
      y(i) = y2 - y1;
    else
      y(i) = 0;
    end
  end

  %Plotting after HPS. 
  figure(2);
  yPlot = y(1:(size(y,2)/300));
  plot(yPlot);

  %2. Low-pass filter
  for i = 1 : (size(x,2) - WS - 1)
    y(i) = sum(y(i : i + WS).^2);
  end 

  %To correct the offset that we created in LPF phase.
  y = [zeros(1,(WS+1)/2) y(1:numel(y-3))];
    
  %Plotting after LPS.
  figure(3);
  yPlot = y(1:(size(y,2)/300));
  plot(yPlot);
  
  %Decision making.
  thresholdCompute = @(alpha, gamma, peak, threshold) alpha * gamma * peak + (1 - alpha) * threshold;
  %%Defining parameters.
  alpha = 0.05;
  gamma = 0.15;
  
  threshold = max(y(1:WSDecision));
    
  %Iterate through the points with the step of window size.
  for i = 1:WSDecision:length(y)-WSDecision
     [max_v,max_i] = max(y(i:i+WSDecision));
     if max_v >= threshold
         y(max_i+i) = 1;
         %Updating the threshold when finding the peak.
         threshold = thresholdCompute(alpha, gamma, max_v, threshold);
     end
  end
  
  indices = find(y==1);
  
 end