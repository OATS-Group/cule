function [ts, totDur, id, cleanUleIdx] = cleanUles(cb, uleIdx)

  % First we want to get all the timestamps
  allTs = cb.gpsTime / 1000;

  % Obtain the original unloading events timestamps
  rawUleTs = allTs(uleIdx);

  % Compute the difference in timestamps and find indices when
  % the time difference > 1
  diffRawUleTs = diff(rawUleTs);
  I = find(diffRawUleTs > 1);

  % Maximum possible number of combine unloading event segments
  numUleSegs = length(I) + 1;
  rawUleSegsTs = cell(numUleSegs, 1);

  for m = 1:numUleSegs
    if m == 1
      rawUleSegsTs{m} = rawUleTs(1:I(m));
      continue
    end

    if m == numUleSegs
      rawUleSegsTs{m} = rawUleTs((I(m-1)+1):length(rawUleTs));
      continue
    end

    rawUleSegsTs{m} = rawUleTs(I(m-1)+1:I(m));
  end

  % Clean the unloading event segments
  ts = {};
  cleanUleIdx = [];
  n = 1;
  totDur = 0;
  for m = 1:length(rawUleSegsTs)
    if sum(diff(rawUleSegsTs{m})) < 10
      continue
    end

    ts{n} = rawUleSegsTs{m};
    totDur = totDur + sum(diff(rawUleSegsTs{m}));

    for mm = 1:length(ts{n})
      tmp = ts{n};
      II = find(tmp(mm) == allTs);
      cleanUleIdx = [cleanUleIdx [II]];
    end

    n = n + 1;
  end

  cleanUleIdx = cleanUleIdx';
  ts = ts';
  id = cb.id;

end%EOF
