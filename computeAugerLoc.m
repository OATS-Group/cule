function [augerLoc] = computeAugerLoc(c)

  % rotation matrix (clockwise)
  r_ = @(b) [cosd(b) sind(b);-sind(b) cosd(b)];

  % get the tablet location
  tLoc = nan(2, length(c.x));
  tLoc(1,:) = c.x;
  tLoc(2,:) = c.y;

  % get the bearing
  b = c.bearing;

  % offsets
  offsets = [-9.2964 -1]';

  % allocate auger spout locations
  augerLoc = nan(2, length(tLoc));

  for m = 1:length(augerLoc)
    augerLoc(:,m) = tLoc(:,m) + r_(b(m)) * offsets;
  end

end %EOF
