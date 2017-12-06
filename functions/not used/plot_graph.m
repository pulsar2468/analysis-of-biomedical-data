function plot_graph(graph)

for i=1:size(graph,2)
distance=graph{i}(2);
end


x = rand(1, 10000);
y = rand(1, 10000);
minAllowableDistance = 0.05;
numberOfPoints = 16;
% Initialize first point.
keeperX = x(1);
keeperY = y(1);
% Try dropping down more points.
counter = 2;
for k = 2 : numberOfPoints
	% Get a trial point.
	thisX = x(k);
	thisY = y(k);
	% See how far is is away from existing keeper points.
	distances = sqrt((thisX-keeperX).^2 + (thisY - keeperY).^2);
    distances
	minDistance = min(distances);
	if minDistance >= minAllowableDistance
		keeperX(counter) = thisX;
		keeperY(counter) = thisY;
		counter = counter + 1;
	end
end
plot(keeperX, keeperY, 'g+');
grid on;

end