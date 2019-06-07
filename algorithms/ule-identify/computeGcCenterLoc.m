function [gcCenterLocs] = computeGcCenterLoc(k, debugFlag)

  if ~exist('debugFlag', 'var')
    debugFlag = false;
  end
  if debugFlag
    I = 10000:12000;
    k.x = k.x(I);
    k.y = k.y(I);
    k.bearing = k.bearing(I);
    k.speed = k.speed(I);
  end

  % Define the constants
  tabletToCenterOffset = 0.9144; % x direction
  tabletToCartCenterOffset = 7.9248; % y direction

  % Define the radius
  r = tabletToCartCenterOffset;

  % TODO: Deal with zero-speed gaps.
  % Obtain the easting, northing, bearing, and speed data
  pts = [k.x k.y k.bearing k.speed];

  pts = [pts(:,1) + tabletToCenterOffset .* cosd(180 - pts(:,3)), ...
         pts(:,2) + tabletToCenterOffset .* sind(180 - pts(:,3)), ...
         pts(:,3:4)];

  % Go through the points to find the grain cart center location
  gcCenterLocs = nan(length(pts),2);
  for m = 1:length(pts)
      % fprintf('On point %d of %d total points\n', m, length(pts));
      curPt = pts(m,:);
      if curPt(4) == 0
        if m == 1
          gcCenterLocs(m,1) = nan;
          gcCenterLocs(m,2) = nan;
          continue
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

  if debugFlag
    figure; hold on;
    hCartCenter = plot(gcCenterLocs(:,1), gcCenterLocs(:,2), 'b*');
    hIsoBlue = plot(k.x, k.y, 'or');
    plot([k.x k.x+cosd(90-pts(:,3))]', ...
        [k.y k.y+sind(90-pts(:,3))]', 'k-');
    plot([k.x gcCenterLocs(:,1)]', [k.y gcCenterLocs(:,2)]', ...
        '--', 'Color', 0.8.*ones(1,3));
    axis equal; grid on;
    legend([hIsoBlue hCartCenter], 'IsoBlue', 'CartCenter');
  end

end %EOF
