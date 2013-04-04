function [ fea_vector ] = gen_all_abs_patches(img_vector, c, patch_size, name)
    start = tic;
    patch_size_init = patch_size;
    x_max = size(img_vector, 2);
    y_max = size(img_vector, 1);
    assert(size(img_vector, 3) == 17);

    parfor (yidx = 1:ceil(y_max/patch_size), 4),
        y = (yidx -1 )*patch_size + 1;
        gen_abs_row_patches(img_vector, c, y, patch_size, strcat(name, int2str(yidx)));
    end

    toc(start)
end