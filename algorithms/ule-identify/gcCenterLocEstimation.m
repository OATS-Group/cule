function [gk] = gcCenterLocEstimation(gpsData)

  % Define the constants
  % tabletToCenterOffset = -0.9144; % x direction
  tabletToCartCenterOffset = 7.9248; % y direction

  % Define the radius
  r = tabletToCartCenterOffset;

  % Load in grain cart data
  D = load(gpsData); % This loads struct `k`

  % Allocate the struct.
  gk = struct('lat', [], 'lon', [], 'x', [], 'y', [], 'bearing', [], ...
    'cartCenterLocs', []);

  % Put the existing gkata into the struct.
  gk.ts = D(:,1) / 1000;
  gk.lat = D(:,2);
  gk.lon = D(:,3);
  gk.speed = D(:,5);
  gk.bearing = D(:,6);

  % Convert the lat/lon pairs to x/y pairs
  [gk.x, gk.y] = convertToXy(D(:,2), D(:,3));

  % TODO: Deal with zero-speed gaps.

  % Obtain the easting and northing data
%  I = (gk.speed > 0);
  pts = [gk.x gk.y gk.bearing gk.speed];

  % Go through the points to find the grain cart center location
  gcCenterLocs = nan(length(pts),2);
  tic;
  for m = 1:length(pts)
      % fprintf('On point %d of %d total points\n', m, length(pts));
      curPt = pts(m,:);
      if curPt(4) == 0
        if m == 1
          gcCenterLocs(m,1) = nan;
          gcCenterLocs(m,2) = nan;
        end
        % if the speed is 0, the cart center should stay at where it was at.
        gcCenterLocs(m,1) = gcCenterLocs(m-1,1);
        gcCenterLocs(m,2) = gcCenterLocs(m-1,2);
        continue;
      end
      idx = genCandidates(pts(m,:), pts, m, 1.25 * r);
      ptsPool = pts(idx,1:2);
      gcCenterLocs(m,:) = findIntersects(curPt(1:2), ptsPool, r);
      if isnan(sum(gcCenterLocs(m,:)))
          % Assume the center is right behind the bearing direction.
          gcCenterLocs(m,1) = curPt(1) + cosd(270-curPt(3)) * r;
          gcCenterLocs(m,2) = curPt(2) + sind(270-curPt(3)) * r;
      end
  end
  toc;

  gk.cartCenterLocs = gcCenterLocs;

  figure; hold on;
  hCartCenter = plot(gcCenterLocs(:,1), gcCenterLocs(:,2), 'b*');
  hIsoBlue = plot(pts(:,1), pts(:,2), 'or');
  plot([pts(:,1) pts(:,1)+cosd(90-pts(:,3))]', ...
      [pts(:,2) pts(:,2)+sind(90-pts(:,3))]', 'k-');
  plot([pts(:,1) gcCenterLocs(:,1)]', [pts(:,2) gcCenterLocs(:,2)]', ...
      '--', 'Color', 0.8.*ones(1,3));
  axis equal; grid on;
  legend([hIsoBlue hCartCenter], 'IsoBlue', 'CartCenter');

end%EOF