function QRSDetect(filename, M, WS)

  signal = load(filename);
  x = signal.val(1,:);

  %Initial plotting.
  figure(1);
  xPlot = x(1:(size(x,2)/512));
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
  yPlot = y(1:(size(y,2)/512));
  plot(yPlot);

  %2. Low-pass filter
  for i = 1 : (size(x,2) - WS - 1)
    y(i) = sum(y(i : i + WS).^2);
  end 

  %Plotting after LPS.
  figure(3);
  yPlot = y(1:(size(y,2)/512));
  plot(yPlot);
  
  %Decision making.
  thresholdCompute = @(alfa, gamma, peak, threshold) alfa * gamma * peak + (1 - alfa) * threshold;
  alfa = 0.05;
  gamma = 0.15;
  window = 200;
  
  %Find first peak.
  peak = max(y(1:window));
  threshold = peak;
  threshold = thresholdCompute(alfa, gamma, peak, threshold)
  
  startPeak = false;
  c = 1;
  for i = 1 : size(x,2)
    if (y(i) > threshold)
      if (!startPeak)
        startPeak = true;
        curMax = y(i);
        curIndex = i;
      end
      if (y(i) > curMax)
        curMax = y(i);
        curIndex = i;
      end
    end
    if (startPeak)
      startPeak = false;
      indices(c) = curIndex;
      c++;
      threshold = thresholdCompute(alfa, gamma, curMax, threshold);
    else
  end
  
  %Plotting after decision making.
  y
 
end