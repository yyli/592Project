function [ fea_vector ] = gen_all_abs_patches(img_vector, c, patch_size)
    start = tic;
    patch_size_init = patch_size;
    x_max = size(img_vector, 2);
    y_max = size(img_vector, 1);
    assert(size(img_vector, 3) == 17);

    fea_vector = zeros(ceil(y_max/patch_size), ceil(x_max/patch_size), 19*34);

    parfor yidx = 1:ceil(y_max/patch_size),
        y = (yidx -1 )*patch_size + 1;
        fea_vector(yidx, :, :) = gen_abs_row_patches(img_vector, c, y, patch_size);
    end

    toc(start)
end