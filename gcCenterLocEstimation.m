clear all;
close all;

% Change current dir.
cd(fileparts(mfilename('fullpath')));
addpath(fullfile(pwd));

% Define the constants
%   tabletToCenterOffset = -0.9144; % x direction
tabletToCartCenterOffset = 7.9248; % y direction

% Define the radius
r = tabletToCartCenterOffset;

% Load in grain cart data
load('./data/renfrow-2/290_renfrow_2.mat'); % This loads struct `k`

% TODO: Deal with zero-speed gaps.

% Obtain the easting and northing data
pts = [k.x(k.speed > 0) k.y(k.speed > 0) k.bearing(k.speed > 0)];

% Go through the points to find the grain cart center location
gcCenterLocs = nan(length(pts),2);
tic;
for m = 1:length(pts)
    % fprintf('On point %d of %d total points\n', m, length(pts));
    curPt = pts(m,:);
    idx = genCandidates(pts(m,:), pts, m, 1.25 * r);
    if length(idx) == 1
        % Assume the center is right behind the bearing direction.
        gcCenterLocs(m,1) = curPt(1)+cosd(270-curPt(3));
        gcCenterLocs(m,2) = curPt(2)+sind(270-curPt(3));
    else
        ptsPool = pts(idx,1:2);
        gcCenterLocs(m,:) = findIntersects(curPt(1:2), ptsPool, r);
        if isnan(sum(gcCenterLocs(m,:)))
            % Assume the center is right behind the bearing direction.
            gcCenterLocs(m,1) = curPt(1)+cosd(270-curPt(3));
            gcCenterLocs(m,2) = curPt(2)+sind(270-curPt(3));
        end
    end
end
toc;

figure; hold on;
hCartCenter = plot(gcCenterLocs(:,1), gcCenterLocs(:,2), 'b*');
hIsoBlue = plot(pts(:,1), pts(:,2), 'or');
plot([pts(:,1) pts(:,1)+cosd(90-pts(:,3))]', ...
    [pts(:,2) pts(:,2)+sind(90-pts(:,3))]', 'k-');
plot([pts(:,1) gcCenterLocs(:,1)]', [pts(:,2) gcCenterLocs(:,2)]', ...
    '--', 'Color', 0.8.*ones(1,3));
axis equal; grid on;
legend([hIsoBlue hCartCenter], 'IsoBlue', 'CartCenter');