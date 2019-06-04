clear all;
close all;

% Tolerance of distance between `augerSpoutLocs` and `gcCenterLocs`
% in meters
d = 6.5;

% Estimate two combines' auger spout locations
% - `augerLocEstimation` will return a struct
% -- the struct has fields:
% --- ts, lat, lon, bearing, augerSpoutLocs
%cbA = augerLocEstimation('data/tablet/renfrow-2/case-7130-gps-fs19.csv');
%cbB = augerLocEstimation('data/tablet/renfrow-2/case-8240-gps-fs19.csv');

% Estimate the grain kart's cart center location
gk = gcCenterLocEstimation('data/tablet/renfrow-2/case-290-gps-fs19.csv');

% Find the distance between the auger spout locations the the cart centers
% at the same timestamp
%cbA.augerSpout2CartCenterDist = computeDist(cbA, gk);
%cbB.augerSpout2CartCenterDist = computeDist(cbB, gk);

% Find the indices where the distance is less than `d`
%cbA.uleIdx = find(cbA.augerSpout2CartCenterDist <= d);
%cbB.uleIdx = find(cbB.augerSpout2CartCenterDist <= d);
