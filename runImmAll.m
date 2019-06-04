function [gdImm] = runImmAll(year, mType)

  % Specify the path
  path = strcat('./data/tablet/', mType);

  % Load in the data
  fname = strcat(path, '_gps_data_', num2str(year));
  fprintf('Loading data `%s`\n', fname);
  load(fname);

  fprintf('Data was successfully loaded!\n');

  % Start IMM algorithm on the loaded data
  fprintf('runImmAll started ...\n\n');
  tic;
  % Allocate the cell array for holding the new GPS data with IMM outputs
  gdImm = cell(1, length(gd));

  for m = 1:length(gd)
    fprintf('ON FIELD %d:\n', m);
    gdImm{m} = runImm(gd{m});
  end
  fprintf('runImmAll finished!\n\n');
  toc;

end %EOF
