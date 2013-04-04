function [ fea_vector ] = gen_abs_vector_patch( img_vector , x, y, patch_size_init)
    max_y = size(img_vector, 1);
    fea_vector = zeros(19, 34);

    patch_size = patch_size_init;
    fea_vector(1, :) = sum_filter( img_vector, x, y, patch_size); % center
    fea_vector(2, :) = sum_filter( img_vector, x, y - patch_size, patch_size); % top
    fea_vector(3, :) = sum_filter( img_vector, x, y + patch_size, patch_size); % bottom
    fea_vector(4, :) = sum_filter( img_vector, x - patch_size, y, patch_size); % left (sub)
    fea_vector(5, :) = sum_filter( img_vector, x + patch_size, y, patch_size); % right (add)

    patch_size = patch_size_init * 3;
    fea_vector(6, :) = sum_filter( img_vector, x, y, patch_size); % center
    fea_vector(7, :) = sum_filter( img_vector, x, y - patch_size, patch_size); % top
    fea_vector(8, :) = sum_filter( img_vector, x, y + patch_size, patch_size); % bottom
    fea_vector(9, :) = sum_filter( img_vector, x - patch_size, y, patch_size); % left (sub)
    fea_vector(10, :) = sum_filter( img_vector, x + patch_size, y, patch_size); % right (add)

    patch_size = patch_size_init * 9;
    fea_vector(11, :) = sum_filter( img_vector, x, y, patch_size); % center
    fea_vector(12, :) = sum_filter( img_vector, x, y - patch_size, patch_size); % top
    fea_vector(13, :) = sum_filter( img_vector, x, y + patch_size, patch_size); % bottom
    fea_vector(14, :) = sum_filter( img_vector, x - patch_size, y, patch_size); % left (sub)
    fea_vector(15, :) = sum_filter( img_vector, x + patch_size, y, patch_size); % right (add)

    fea_vector(16, :) = sum_filter_column( img_vector, x, patch_size, 1);
    fea_vector(17, :) = sum_filter_column( img_vector, x, patch_size, 2);
    fea_vector(18, :) = sum_filter_column( img_vector, x, patch_size, 3);
    fea_vector(19, :) = sum_filter_column( img_vector, x, patch_size, 4);
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

function [ ret_sum ] = sum_filter_column(img_vector, x, patch_size, patch_num)
    max_x = size(img_vector, 2);
    max_y = size(img_vector, 1);
    assert(size(img_vector, 3) == 17);

    xlower = x;
    xupper = x + patch_size;
    ylower = ceil((patch_num - 1) * max_y/4);
    yupper = ceil(patch_num * max_y/4)-1;
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
        %         if (i < 1)
        %             i_ = 1;
        %         elseif (i > max_x)
        %             i_ = max_x;
        %         elseif (j < 1)
        %             j_ = 1;
        %         elseif (j > max_y)
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