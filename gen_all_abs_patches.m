function [ fea_vector ] = gen_all_abs_patches(img_vector, patch_size)
% all_abs_patch s1 = scale 1, s2 = scale 2, s3 = scale 3, col = col 2 scale 3
start = tic;
patch_size_init = patch_size;
x_max = size(img_vector, 2);
y_max = size(img_vector, 1);
assert(size(img_vector, 3) == 17);

c = zeros(4, x_max, 34);

y_diff = ceil(y_max/4);
for x = 1:x_max, 
	for y = 1:y_diff:y_max,
		xlower = x;
		xupper = x;
		if (xupper > x_max)
			xupper = x_max;
		end
		ylower = y;
		yupper = y + y_diff - 1;
		if (yupper > y_max)
			yupper = y_max;
		end
	    for f = 1:2:34,
	        c(ceil(y/y_diff), ceil(x), f) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2))));
	        c(ceil(y/y_diff), ceil(x), f+1) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2)).^2));
	    end
	end
end

for x = 1:patch_size:x_max, 
	midstart = tic;
	for y = 1:patch_size:y_max,
		fea_vector = zeros(ceil(y_max/patch_size), ceil(x_max/patch_size), 19*34);
		patch_size_temp = patch_size;
	    fea_vector(0*34+1:1*34) = sum_filter( img_vector, x, y, patch_size_temp); % center
	    fea_vector(1*34+1:2*34) = sum_filter( img_vector, x, y - patch_size_temp, patch_size_temp); % top
	    fea_vector(2*34+1:3*34) = sum_filter( img_vector, x, y + patch_size_temp, patch_size_temp); % bottom
	    fea_vector(3*34+1:4*34) = sum_filter( img_vector, x - patch_size_temp, y, patch_size_temp); % left (sub)
	    fea_vector(4*34+1:5*34) = sum_filter( img_vector, x + patch_size_temp, y, patch_size_temp); % right (add)

	    patch_size_temp = patch_size_init * 3;
	    fea_vector(5*34+1:6*34) = sum_filter( img_vector, x, y, patch_size_temp); % center
	    fea_vector(6*34+1:7*34) = sum_filter( img_vector, x, y - patch_size_temp, patch_size_temp); % top
	    fea_vector(7*34+1:8*34) = sum_filter( img_vector, x, y + patch_size_temp, patch_size_temp); % bottom
	    fea_vector(8*34+1:9*34) = sum_filter( img_vector, x - patch_size_temp, y, patch_size_temp); % left (sub)
	    fea_vector(9*34+1:10*34) = sum_filter( img_vector, x + patch_size_temp, y, patch_size_temp); % right (add)

	    patch_size_temp = patch_size_init * 9;
	    fea_vector(10*34+1:11*34) = sum_filter( img_vector, x, y, patch_size_temp); % center
	    fea_vector(11*34+1:12*34) = sum_filter( img_vector, x, y - patch_size_temp, patch_size_temp); % top
	    fea_vector(12*34+1:13*34) = sum_filter( img_vector, x, y + patch_size_temp, patch_size_temp); % bottom
	    fea_vector(13*34+1:14*34) = sum_filter( img_vector, x - patch_size_temp, y, patch_size_temp); % left (sub)
	    fea_vector(14*34+1:15*34) = sum_filter( img_vector, x + patch_size_temp, y, patch_size_temp); % right (add)

	    xlower = x;
	    xupper = x + patch_size_temp;
	    if (xupper > x_max)
	    	xupper = x_max;
	    end

	    fea_vector(15*34+1:16*34) = sum(c(1, xlower:xupper, :));
	    fea_vector(16*34+1:17*34) = sum(c(2, xlower:xupper, :));
	    fea_vector(17*34+1:18*34) = sum(c(3, xlower:xupper, :));
	    fea_vector(18*34+1:19*34) = sum(c(4, xlower:xupper, :));
 	end
    time = toc(midstart);
    fprintf('%8.3f%%, %10.5f, %10.5f\n', x/x_max*100, time, toc(start));
end

toc(start)

all_abs_patch = struct('s1', s1, 's2', s2, 's3', s3, 'c', c);
toc(start)
end

function [ ret_sum ] = sum_filter( img_vector, x, y, patch_size)
    max_x = size(img_vector, 2);
    max_y = size(img_vector, 1);
    assert(size(img_vector, 3) == 17);

    xlower = x;
    xupper = x + patch_size - 1;
    ylower = y;
    yupper = y + patch_size - 1;
    ret_sum = zeros(1, 34);

    if (xlower < 1)
        xlower = 1;
    elseif (xupper > max_x)
        xupper = max_x;
    end

    if (ylower < 1)
        ylower = 1;
    elseif (yupper > max_y)
        yupper = max_y;
    end

    for f = 1:2:34,
        % for j = ylower:yupper,
        %     for i = xlower:xupper,
        %         j_ = j;
        %         i_ = i;
        %         if i < 1
        %             i_ = 1;
        %         end
        %         if i > max_x
        %             i_ = max_x;
        %         end
        %         if j < 1
        %             j_ = 1;
        %         end
        %         if j > max_y
        %             j_ = max_y;
        %         end
        %         addterm = abs(img_vector(j_, i_, round(f/2)));

        %         ret_sum(f) = ret_sum(f) + addterm;
        %         ret_sum(f+1) = ret_sum(f+1) + addterm^2;
        %     end
        % end
        ret_sum(f) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2))));
        ret_sum(f+1) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2)).^2));
    end
end