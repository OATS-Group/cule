function [m, b, f] = findLineSlopeIntercept(pcur, plast)

  % y = mx + b
  % We need to find both `m` (slope) and `b` (intercept)

  if (pcur(1) - plast(1)) == 0
    f = 1;
    m = inf;
    b = nan;
    return;
  end

  % Find the slope (rise over run)
  m = (pcur(2) - plast(2)) / (pcur(1) - plast(1));

  % Find the intercept
  b = pcur(2) - m * pcur(1);

  f = 0;

  %TODO: if `m` is too big (inf), we should find x-intercept instead

end %EOF
