function [] = parse_all(prefix)
	folder = strcat(prefix, 'Depth');
	listing = dir(folder);
	numfiles = size(listing, 1) - 2;
	for i = 1:numfiles,
		depth_from_file(strcat(folder, '/', listing(i+2).name), i);
		fprintf('Percent: %8.4f\n', i/numfiles*100)
	end

	folder = strcat(prefix, 'Img');
	listing = dir(folder);
	for i = 1:numfiles,
		features_from_file(strcat(folder, '/', listing(i+2).name), i);
		fprintf('Percent: %8.4f\n', i/numfiles*100)
	end
end