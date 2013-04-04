function [ p ] = gen_abs_patch(img_vector, patch_size)
x_max = size(img_vector, 2);
y_max = size(img_vector, 1);
assert(size(img_vector, 3) == 17);

p = zeros(ceil(y_max/patch_size), ceil(x_max/patch_size), 34);

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
            p(ceil(y/patch_size), ceil(x/patch_size), f) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2))));
            p(ceil(y/patch_size), ceil(x/patch_size), f+1) = sum(sum(img_vector(ylower:yupper, xlower:xupper,round(f/2)).^2));
        end
    end
end
end