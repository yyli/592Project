function [] = parse_all(prefix)
	folder = strcat(prefix, 'Depth');
	listing = dir(folder);
	for i = 1:10,
		depth_from_file(strcat(folder, '/', listing(i+2).name), i);
	end

	folder = strcat(prefix, 'Img');
	listing = dir(folder);
	for i = 1:10,
		features_from_file(strcat(folder, '/', listing(i+2).name), i);
	end
end