function [totalYield] = runCule(year)

  addpath('./algorithms/ule-identify/');

  [uleSegs, cleanUleIdx] = uleIdentify(year, 7, 0.1, 0.5);

  save('./data/tablet/combine_uleidx_2018.mat');

  totalYield = cell(length(uleSegs), 1);

  for m = 1:length(uleSegs)
    totalYield{m}{1} = uleSegs{m}{1}.totDur * 3.2;
    totalYield{m}{2} = uleSegs{m}{2}.totDur * 4;
  end

end%EOF
