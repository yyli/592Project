function [ all_abs_patch ] = gen_all_abs_patches(img_vector, patch_size)
% all_abs_patch s1 = scale 1, s2 = scale 2, s3 = scale 3, col = col 2 scale 3
start = tic;
patch_size_init = patch_size;
x_max = size(img_vector, 2);
y_max = size(img_vector, 1);
assert(size(img_vector, 3) == 17);

s1 = zeros(ceil(y_max/patch_size), ceil(x_max/patch_size), 34);
s2 = zeros(ceil(y_max/(patch_size*3)), ceil(x_max/(patch_size*3)), 34);
s3 = zeros(ceil(y_max/(patch_size*9)), ceil(x_max/(patch_size*9)), 34);
c = zeros(4, ceil(x_max/(patch_size*9)));

for x = 1:patch_size:x_max, 
	for y = 1:patch_size:y_max,
		xlower = x;
		xupper = x + patch_size - 1;
		if (xupper > x_max)
			xupper = x_max;
		end
		ylower = y;
		yupper = y + patch_size - 1;
		if (yupper > y_max)
			yupper = y_max;
		end
	    for f = 1:2:34,
	        s1(ceil(y/patch_size), ceil(x/patch_size), f) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2))));
	        s1(ceil(y/patch_size), ceil(x/patch_size), f+1) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2)).^2));
	    end
	end
end

patch_size = patch_size_init * 3;
for x = 1:patch_size:x_max, 
	for y = 1:patch_size:y_max,
		xlower = x;
		xupper = x + patch_size - 1;
		if (xupper > x_max)
			xupper = x_max;
		end
		ylower = y;
		yupper = y + patch_size - 1;
		if (yupper > y_max)
			yupper = y_max;
		end
	    for f = 1:2:34,
	        s2(ceil(y/patch_size), ceil(x/patch_size), f) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2))));
	        s2(ceil(y/patch_size), ceil(x/patch_size), f+1) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2)).^2));
	    end
	end
end

patch_size = patch_size_init * 9;
for x = 1:patch_size:x_max, 
	for y = 1:patch_size:y_max,
		xlower = x;
		xupper = x + patch_size - 1;
		if (xupper > x_max)
			xupper = x_max;
		end
		ylower = y;
		yupper = y + patch_size - 1;
		if (yupper > y_max)
			yupper = y_max;
		end
	    for f = 1:2:34,
	        s3(ceil(y/patch_size), ceil(x/patch_size), f) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2))));
	        s3(ceil(y/patch_size), ceil(x/patch_size), f+1) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2)).^2));
	    end
	end
end

patch_size = patch_size_init * 9;
y_diff = ceil(y_max/4);
for x = 1:patch_size:x_max, 
	for y = 1:y_diff:y_max,
		xlower = x;
		xupper = x + patch_size - 1;
		if (xupper > x_max)
			xupper = x_max;
		end
		ylower = y;
		yupper = y + y_diff - 1;
		if (yupper > y_max)
			yupper = y_max;
		end
	    for f = 1:2:34,
	        s1(ceil(y/y_diff), ceil(x/patch_size), f) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2))));
	        s1(ceil(y/y_diff), ceil(x/patch_size), f+1) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2)).^2));
	    end
	end
end

all_abs_patch = struct('s1', s1, 's2', s2, 's3', s3, 'c', c);
toc(start)
end