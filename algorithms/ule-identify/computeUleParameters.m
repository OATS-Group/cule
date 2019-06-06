function [uleParameters] = computeUleParameters(cb, gk)

  uleParameters = nan(length(cb.gpsTime), 3);
  for m = 1:length(cb.gpsTime)
    I = find((gk.gpsTime / 1000) == (cb.gpsTime(m) / 1000));
    if ~isempty(I)
      p1 = [cb.augerSpoutLocs(m,1) cb.augerSpoutLocs(m,2)];
      p2 = [gk.cartCenterLocs(I,1) gk.cartCenterLocs(I,2)];
      uleParameters(m,1) = norm(p1 - p2);
      uleParameters(m,2) = cb.mu(m,1) - mean(gk.mu(I,1));
      uleParameters(m,3) = cb.v(m,1) - mean(gk.v(I,1));
    end
  end

end%EOF
