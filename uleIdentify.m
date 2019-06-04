function [uleIdx] = uleIdentify(year, dEps, muEps, vEps)

  % Load different data files from the same year
  cbPath = './data/tablet/combine';
  gkPath = './data/tablet/kart';

  cbAugerLocsFn = strcat(cbPath, '_immas_', num2str(year));
  gkCenterLocsFn = strcat(gkPath, '_immcc_', num2str(year));

  fprintf('Loading data `%s`\n', cbAugerLocsFn);

  load(cbAugerLocsFn);

  fprintf('Data was successfully loaded!\n');

  fprintf('Loading data `%s`\n', gkCenterLocsFn);

  load(gkCenterLocsFn);

  fprintf('Data was successfully loaded!\n');

  % Allocate the indices
  uleIdx = cell(1, length(gdImmAS));

  fprintf('uleIdentify started ...\n\n');
  tic;
  % Compute the distance
  for m = 1:length(gdImmAS)
    fprintf('ON FIELD %d\n', m);
    % We don't want to process the empty cells
    if isempty(gdImmAS{m})
      fprintf('\tNo GPS data in this field, skip to the next one!\n\n');
      continue
    end
    k = gdImmCC{m}{1};
    for n = 1:length(gdImmAS{m})
      fprintf('\tDATA SET %d\n', n);
      uleParameters = computeUleParameters(gdImmAS{m}{n}, k);
      uleIdx{m}{n} = find(uleParameters(:,1) <= dEps ...
        & (uleParameters(:,2) >= -muEps & uleParameters(:,2) <= muEps) ...
        & (uleParameters(:,3) >= -vEps & uleParameters(:,3) <= vEps));
    end
    fprintf('\n');
  end
  fprintf('uleIdentify finished!\n\n');
  toc;

end%EOF
