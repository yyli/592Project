function [ fea_vector ] = gen_all_abs_patches(img_vector, c, patch_size)
% all_abs_patch s1 = scale 1, s2 = scale 2, s3 = scale 3, col = col 2 scale 3
start = tic;
patch_size_init = patch_size;
x_max = size(img_vector, 2);
y_max = size(img_vector, 1);
assert(size(img_vector, 3) == 17);

parfor yidx = 1:ceil(y_max/patch_size),
    y = (yidx -1 )*patch_size + 1;
    midstart = tic;
    xidx = 1;
    for x = 1:patch_size:x_max, 
        assert(yidx == ceil(y/patch_size));
        assert(xidx == ceil(x/patch_size));
		patch_size_temp = patch_size;
        fea_vector = zeros(ceil(x_max/patch_size), 19*34);
	    fea_vector(xidx, 0*34+1:1*34) = sum_filter( img_vector, x, y, patch_size_temp); % center
	    fea_vector(xidx, 1*34+1:2*34) = sum_filter( img_vector, x, y - patch_size_temp, patch_size_temp); % top
	    fea_vector(xidx, 2*34+1:3*34) = sum_filter( img_vector, x, y + patch_size_temp, patch_size_temp); % bottom
	    fea_vector(xidx, 3*34+1:4*34) = sum_filter( img_vector, x - patch_size_temp, y, patch_size_temp); % left (sub)
	    fea_vector(xidx, 4*34+1:5*34) = sum_filter( img_vector, x + patch_size_temp, y, patch_size_temp); % right (add)

	    patch_size_temp = patch_size_init * 3;
	    fea_vector(xidx, 5*34+1:6*34) = sum_filter( img_vector, x, y, patch_size_temp); % center
	    fea_vector(xidx, 6*34+1:7*34) = sum_filter( img_vector, x, y - patch_size_temp, patch_size_temp); % top
	    fea_vector(xidx, 7*34+1:8*34) = sum_filter( img_vector, x, y + patch_size_temp, patch_size_temp); % bottom
	    fea_vector(xidx, 8*34+1:9*34) = sum_filter( img_vector, x - patch_size_temp, y, patch_size_temp); % left (sub)
	    fea_vector(xidx, 9*34+1:10*34) = sum_filter( img_vector, x + patch_size_temp, y, patch_size_temp); % right (add)

	    patch_size_temp = patch_size_init * 9;
	    fea_vector(xidx, 10*34+1:11*34) = sum_filter( img_vector, x, y, patch_size_temp); % center
	    fea_vector(xidx, 11*34+1:12*34) = sum_filter( img_vector, x, y - patch_size_temp, patch_size_temp); % top
	    fea_vector(xidx, 12*34+1:13*34) = sum_filter( img_vector, x, y + patch_size_temp, patch_size_temp); % bottom
	    fea_vector(xidx, 13*34+1:14*34) = sum_filter( img_vector, x - patch_size_temp, y, patch_size_temp); % left (sub)
	    fea_vector(xidx, 14*34+1:15*34) = sum_filter( img_vector, x + patch_size_temp, y, patch_size_temp); % right (add)

	    xlower = x;
	    xupper = x + patch_size_temp;
	    if (xupper > x_max)
	    	xupper = x_max;
	    end

	    fea_vector(xidx, 15*34+1:16*34) = sum(c(1, xlower:xupper, :));
	    fea_vector(xidx, 16*34+1:17*34) = sum(c(2, xlower:xupper, :));
	    fea_vector(xidx, 17*34+1:18*34) = sum(c(3, xlower:xupper, :));
	    fea_vector(xidx, 18*34+1:19*34) = sum(c(4, xlower:xupper, :));
        xidx = xidx + 1;
 	end
    time = toc(midstart);
    fprintf('%8.3f%%, %10.5f, %10.5f\n', y/y_max*100, time, toc(start));
    drawnow('update')
end

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