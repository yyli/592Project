function [ fea_vector ] = gen_relative_vector_patch( img_vector , x, y, patch_size_init)
    max_x = size(img_vector, 2);
    max_y = size(img_vector, 1);
    xlower = x - floor(patch_size_init/2);
    xupper = x + floor(patch_size_init/2) - mod(patch_size_init+1,2);
    ylower = y - floor(patch_size_init/2);
    yupper = y + floor(patch_size_init/2) - mod(patch_size_init+1,2);

    data = zeros(17, patch_size_init*patch_size_init);
    fea_vector = zeros(17, 10);

    for f = 1:17,
        count = 1;
        for j = ylower:yupper,
            for i = xlower:xupper,
                addterm = 0;
                if (i > 0 && i <= max_x && j > 0 && j < max_y)
                    addterm = img_vector(j, i, f);
                end

                data(f, count) = addterm;
                count = count + 1;
            end
        end
        [bins, fea_vector(f, :)] = hist(data(f, :), 10);
    end
end