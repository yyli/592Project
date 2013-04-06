function [] = test()
	start = tic;
	img = imread('traintest1.jpg');
	img_vector = generate_filter_output(img);
	p = gen_abs_patch(img_vector, 8);
	c = gen_abs_columns(img_vector);
	out = gen_all_abs_patches_temp(p, c, 8);
	toc(start)

	% max_y = 2272;
	% max_x = 1704;
	% norm_x = 305;
	% norm_y = 55;

	% depthret = zeros(max_y, max_x);

	% for y = 1:max_y,
	% 	for x = 1:max_x,
	% 		iy = ceil(y/max_y * norm_y);
	% 		ix = ceil(x/max_x * norm_x);
	% 		if iy <= 0
	% 			iy = 1
	% 		end 
	% 		if ix <= 0
	% 			ix = 1
	% 		end
	% 		depthret(y, x) = normd(floor(iy), floor(ix));
	% 	end
	% end

	% depth = depthret;

end