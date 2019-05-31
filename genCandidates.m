function [idx] = genCandidates(curPt, allPts, curPtIdx, limitR)

% We want to throw away the points with bigger indices and narrow the
% possible search points by distance (strictly less than limitR).
minIdx = curPtIdx;
for idxPtToInspect = (curPtIdx-1):-1:1    
    ptToInspect = allPts(idxPtToInspect, :);
    
    if norm(ptToInspect(1:2)-curPt(1:2))<limitR
        minIdx = idxPtToInspect;
    else
        break;
    end
end
idx = minIdx:curPtIdx;

end
%EOF