function [ depth ] = test()
	tic
	patch_size = 8;

	img = imread('traintest1.jpg');
	rows = size(img, 2);
	cols = size(img, 1);
	load('traintest1.mat');
	true_d = Position3DGrid(:,:,4);

	clear Position3DGrid;

	abs_vector = generate_filter_output(img);
	depth = abs_vector;

	for y = 1:patch_size:cols - patch_size,
		tic
		for x = 1:patch_size:rows - patch_size, 
			feature_vector = gen_abs_vector_patch(abs_vector, x, y, patch_size);
		end
		toc
	end
	toc
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