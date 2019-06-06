clear all;
close all;

load('../data/tablet/combine_uleidx_2018.mat');
load('../data/tablet/combine_imm_2018.mat');

dataLen = length(gdImm);

for m = 1:length(gdImm)
  for n = 1:length(gdImm{m})
    ftitle = sprintf(strcat(gdImm{m}{n}.id, ' fs', num2str(m)));
    fname = ftitle;
    fname(isspace(fname)) = [];

    h = figure('pos', [10 10 1200 900]);
    hold on
    scatter(gdImm{m}{n}.lon, gdImm{m}{n}.lat, 15, 'r');
    scatter(gdImm{m}{n}.lon(cleanUleIdx{m}{n}), ...
      gdImm{m}{n}.lat(cleanUleIdx{m}{n}), 15, 'yx');
    plot_google_map('Maptype', 'hybrid');

    xlabel('Longitude');
    ylabel('Latitude');
    title(ftitle);

    pause(2)

%    export_fig(strcat('../outputs/', fname, '.png'),  '-painters', ...
%      '-transparent');

    close;
  end
end
