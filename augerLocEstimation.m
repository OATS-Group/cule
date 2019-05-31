clear all;
close all;

% Change current dir.
cd(fileparts(mfilename('fullpath')));
addpath(fullfile(pwd));

% Load the data file D(:,1) - lat D(:,2) - lon D(:,3) - bearing
D = load('./data/renfrow-2/7130_gps.log');

% Allocate the struct.
d = struct('lat', [], 'lon', [], ...
    'x', [], 'y', [], ...
    'bearing', []);

% Put the existing data into the struct
d.lat = D(:,1);
d.lon = D(:,2);
d.bearing = D(:,3);

% TODO: Take care of points from different UTM zones; At least keep the
% zones for future reference.

% Convert the lat/lon pairs to x/y pairs
[d.x, d.y] = convertToXy(D(:,1), D(:,2));

% Compute the auger locations
augerLoc = computeAugerLoc(d, true);
