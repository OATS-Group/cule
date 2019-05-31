function [idx] = genCandidates(curPt, allPts, curPtIdx, limitR)

  % First off, we want to narrow the possible search points by distance
  [Idx, D] = rangesearch(allPts, curPt, limitR);

  % Then, we want to throw away the points with bigger indices
  M = Idx{1};
  idx = M(find(Idx{1} <= curPtIdx));

end %EOF
