clear all;
close all;

% Define the constants
%tabletToCenterOffset = -0.9144; % x direction
tabletToCartCenterOffset = 7.9248; % y direction

% Define the radius
r = tabletToCartCenterOffset;

% Load in grain cart data
load('./data/renfrow-2/290_renfrow_2.mat'); % This loads struct `k`

% Obtain the easting and northing data
pts = [k.x(k.speed > 0) k.y(k.speed > 0)];

% Go through the points to find the grain cart center location
gcCenterLocs = nan(length(pts),2);
for m = 1:length(pts)
  fprintf('On point %d of %d total points\n', m, length(pts));
  curPt = pts(m,:);
  idx = genCandidates(pts(m,:), pts, m, 1.25 * r);
  if length(idx) == 1
    gcCenterLocs(m,:) = nan;
    continue
  end
  ptsPool = pts(idx,:);
  gcCenterLocs(m,:) = findIntersects(curPt, ptsPool, r);
  if sum(gcCenterLocs(m,:)) == 2
    gcCenterLocs(m,:) = gcCenterLocs(m-1,:);
  end
end
