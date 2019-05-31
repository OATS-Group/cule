function [onLine] = checkPtOnLine(pcur, plast, p, eps)

  % We want to check whether a point `p` is in between `pcur` and `plast`

  % First, we compute the distance between `pcur` and `plast`
  d = norm(pcur - plast);

  % Check if the `p` is within distance with a given precision
  if norm(pcur - p) + norm(p - plast) - d > -eps && ...
    norm(pcur - p) + norm(p - plast) - d < eps
    onLine = true;
  else
    onLine = false;
  end

end %EOF
