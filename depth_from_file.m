function [] = features_from_file(name, num)
	x_max = 213;
	y_max = 284;
	load(name);
	depth = resize_depth(Position3DGrid(:, :, 4), x_max, y_max);
	save(strcat('ParsedTestDepth/', int2str(num), '.mat'), 'depth', '-v7.3');
end