function [ depthret ] = resize_depth( depth , max_x, max_y)
	norm_x = size(depth, 2);
	norm_y = size(depth, 1);

	depthret = zeros(max_y, max_x);

	for y = 1:max_y,
		for x = 1:max_x,
			iy = ceil(y/max_y * norm_y);
			ix = ceil(x/max_x * norm_x);
			if iy <= 0
				iy = 1
			end 
			if ix <= 0
				ix = 1
			end
			depthret(y, x) = depth(floor(iy), floor(ix));
		end
	end
end