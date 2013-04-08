function [] = features_from_file(name, num)
	start = tic;
	patch_size = 8;
	img = imread(name);
	img_vector = generate_filter_output(img);
	c = gen_abs_columns(img_vector);
	p = gen_abs_patch(img_vector, patch_size);
	fea_vector = gen_all_abs_patches(p, c, patch_size);
	save(strcat('ParsedImg/', int2str(num), '.mat'), 'fea_vector', '-v7.3');
	toc(start)
end