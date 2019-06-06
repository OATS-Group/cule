function [augerLocs] = computeAugerLoc(c, debugFlag)
  % Example tests:
  %     (1)
  %         c.x = [0 1 4]'; c.y = [-1 2 -3]'; c.bearing = [180 30 45]';
  %         computeAugerLoc(c, true);
  %     (2)
  %         c.x = 1; c.y = 2; c.bearing = 30; computeAugerLoc(c, true);

  if ~exist('debugFlag', 'var')
      debugFlag = false;
  end

  % rotation matrix (clockwise)
  r_ = @(b) [cosd(b) sind(b); -sind(b) cosd(b)];

  % get the tablet location
  numInputLocs = length(c.x);
  tLoc = nan(2, numInputLocs);
  tLoc(1,:) = c.x;
  tLoc(2,:) = c.y;

  % TODO: Deal with the inacurate bearing issue by either
  %     (1) Use locations only; (2) Clean the bearing of zero-speed
  %     locations.

  % get the bearing
  b = c.bearing;

  % offsets
  offsets = [-9.2964 -1]';

  % allocate auger spout locations
  augerLocs = nan(2, numInputLocs);

  for m = 1:numInputLocs
      augerLocs(:,m) = tLoc(:,m) + r_(b(m)) * offsets;
  end

  augerLocs = augerLocs';

  if debugFlag
      figure;
      hold on;
      hAuger = plot(augerLocs(1,:), augerLocs(2,:), 'xb');
      hTab = plot(c.x, c.y, 'or');
      plot([c.x c.x+cosd(90-c.bearing)]', ...
          [c.y c.y+sind(90-c.bearing)]', 'k-');
      plot([c.x augerLocs(1,:)']', [c.y augerLocs(2,:)']', ...
          '--', 'Color', 0.8.*ones(1,3));
      axis equal; grid on;
      legend([hTab hAuger], 'IsoBlue', 'Auger');
  end

end %EOF
