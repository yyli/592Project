function [ fea_vector ] = generate_all_image_features(img)
	patch_size = 8;
	img_vector = generate_filter_output(img);
	c = gen_abs_columns(img_vector);
	p = gen_abs_patch(img_vector, patch_size);
	fea_vector = gen_all_abs_patches(p, c, patch_size);
end