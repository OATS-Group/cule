function [interPt] = findIntersects(curPt, ptsPool, r)

interPt = nan;
[numPts,~] = size(ptsPool);

for idxPt = (numPts-1):-1:1
    [S, I, F] = findLineSlopeIntercept(ptsPool(idxPt,:), ...
        ptsPool(idxPt+1,:));
    
    % TODO: Deal with the F==1 case (i.e. when S is inf).
    
    % Use linecirc to compute the intercept
    [xout, yout] = linecirc(S, I, curPt(1), curPt(2), r);
    
    % Check if the intersection point is on the specified line segment.
    for idxInterPt = 1:length(xout)
        curX = xout(idxInterPt);
        curY = yout(idxInterPt);
        
        if curX>=min(ptsPool(idxPt,1), ptsPool(idxPt+1,1)) ...
                && curX<=max(ptsPool(idxPt,1), ptsPool(idxPt+1,1)) ...
                && curY>=min(ptsPool(idxPt,2), ptsPool(idxPt+1,2)) ...
                && curY<=max(ptsPool(idxPt,2), ptsPool(idxPt+1,2))
            interPt = [curX, curY];
            return
        end
    end
end

end
%EOF