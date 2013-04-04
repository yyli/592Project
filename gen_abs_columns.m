function [ c ] = gen_abs_columns(img_vector)
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
end