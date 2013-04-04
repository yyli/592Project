function [ fea_vector ] = test(img_vector, c, patch_size)
    start = tic;
    patch_size_init = patch_size;
    x_max = size(img_vector, 2);
    y_max = size(img_vector, 1);
    assert(size(img_vector, 3) == 17);

    fea_vector = zeros(ceil(y_max/patch_size), ceil(x_max/patch_size), 19*34);

    parfor yidx = 1:ceil(y_max/patch_size),
    	y = (yidx -1 )*patch_size + 1;
    	gen_abs_row_patches(img_vector, c, y, patch_size);
    	% fea_vector(yidx, :, :) = gen_abs_row_patches(img_vector, c, y, patch_size);
    end

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