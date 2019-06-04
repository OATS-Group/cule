function [gdImmAS] = augerLocEstimation(year)

  addpath('./algorithms/pos-estimate/');

  % Load in the data
  % - with assumption that the path and the data both exist
  % -- after loading the data in, the workspace will have `gdImm`
  fname = strcat('./data/tablet/combine', '_imm_', num2str(year));

  fprintf('Loading data `%s`\n', fname);

  load(fname);

  fprintf('Data was successfully loaded!\n');

  fprintf('augerLocEstimation started ...\n\n');
  tic;
  gdImmAS = gdImm;
  % Compute the auger locations
  for m = 1:length(gdImm)
    fprintf('ON FIELD %d\n', m);
    % We don't want to process the empty cells
    if isempty(gdImm{m})
      fprintf('\tNo GPS data in this field, skip to the next one!\n\n');
      continue
    end
    for n = 1:length(gdImm{m})
      fprintf('\tDATA SET %d\n', n);
      gdImmAS{m}{n}.augerSpoutLocs = computeAugerLoc(gdImm{m}{n}, false);
    end
    fprintf('\n');
  end
  fprintf('augerLocEstimation finished!\n\n');
  toc;

end%EOF
