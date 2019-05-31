function [interPt] = findIntersects(curPt, ptsPool, r)

  interPt = nan;

  % Get the size of the ptsPool array
  [a,b] = size(ptsPool);

  if a == 1
    %fprintf('\tfindIntersects: exhausted the pool, return nan!\n');
    interPt = nan;
    return;
  else
    % Compute the slope and y-intercept between the current point
    % and the point in the ptsPool
    [S, I, F] = findLineSlopeIntercept(ptsPool(end,:), ptsPool(end-1,:));
    if F
      interPt = F;
      return;
    end
  end

  % Use linecirc to compute the intercept
  [xout, yout] = linecirc(S, I, curPt(1), curPt(2), r);

  % Check if any points are on the specified line
  onLine = nan(1,length(xout));
  for mm = 1:length(xout)
    onLine(mm) = checkPtOnLine(ptsPool(end,:), ptsPool(end-1,:), ...
      [xout(mm) yout(mm)], 0.1);
  end

  if ~isempty(find(onLine == true))
    %fprintf('\tfindIntersects: no recursion\n');
    % If the intersected point is on the line, then we are good
    I = find(onLine == true);
    interPt = [min(xout(I)) min(yout(I))];
    %fprintf('\tfindIntersects: point is on the line, return the result!\n');
  else
    %fprintf('\tfindIntersects: recursion\n');
    % If it is not, then we recursively call the function to find the point
    % Delete the last element in the pool
    ptsPool(end,:) = [];
    interPt = findIntersects(curPt, ptsPool, r);
  end

end %EOF
