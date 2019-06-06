function [cb] = augerLocEstimation(gpsData)

  % `gpsData` should be a csv file with the following fields (with this order):
  %  - gpsTime, lat, lon, altitude, speed, bearing, accuracy
  %  -- we currently don't need everything but we load them in anyways.
  D = load(gpsData);

  % Allocate a struct.
  cb = struct('lat', [], 'lon', [], 'x', [], 'y', [], 'bearing', [], ...
    'augerSpoutLocs', []);

  % Put the existing data into a struct.
  cb.ts = D(:,1) / 1000;
  cb.lat = D(:,2);
  cb.lon = D(:,3);
  cb.bearing = D(:,6);

  % TODO: Take care of points from different UTM zones; At least keep the
  % zones for future reference.

  % Convert the lat/lon pairs to x/y pairs
  [cb.x, cb.y] = convertToXy(D(:,2), D(:,3));

  tic;
  % Compute the auger locations
  cb.augerSpoutLocs = computeAugerLoc(cb, false);
  toc;

end%EOF
