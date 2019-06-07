function [totalYield] = runCule(year)

  addpath('./algorithms/ule-identify/');

  [totalDuration, uleIdx] = uleIdentify(year, 7, 0.1, 0.5);

  save('./data/tablet/combine_uleidx_2018.mat');

  totalYield = nan(length(uleIdx), 1);

  for m = 1:length(totalYield)
    totalYield(m,1) = totalDuration{m}{1} * 3.2 + totalDuration{m}{2} * 4;
  end

end%EOF
