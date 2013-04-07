function [] = features_from_file(name, num)
	x_max = 213;
	y_max = 283;
	load(name);
	depth = resize_depth(Position3DGrid(:, :, 4), x_max, y_max);
	save(strcat('ParsedDepth/', int2str(num), '.mat'), 'depth');
end