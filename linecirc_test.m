clear all;
close all;

% test x-y coordinates
x = [743856.702663042 743856.806540117 743856.893807499];
y = [4505666.08097073 4505664.72175397 4505663.378663393];

figure; hold on; axis equal;
plot(x, y, 'r-o'); grid minor;

% draw circle
circle_x = x(3);
circle_y = y(3);
r = 8;
viscircles([circle_x, circle_y], r, 'Color', 'b');

[S, I] = findLineSlopeIntercept([x(3) y(3)], [x(2) y(2)]);

% find the intersection
[xout, yout] = linecirc(S, I, circle_x, circle_y, r)

online = checkPtOnLine([x(3) y(3)], [x(2) y(2)], [xout(1) yout(1)], 0.1)
online = checkPtOnLine([x(3) y(3)], [x(2) y(2)], [xout(2) yout(2)], 0.1)

% plot the points
scatter(xout, yout, 70, 'k^', 'filled')
