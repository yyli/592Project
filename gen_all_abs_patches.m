function [ fea_vector ] = gen_all_abs_patches(p, c, original_patch_size)
    start = tic;
    x_max = size(p, 2);
    y_max = size(p, 1);
    fea_vector = zeros(y_max, x_max, 19*34);

    for x = 1:x_max,
        for y = 1:y_max,
            fea_vector(y, x, 0*34+1:1*34) = p(y, x, :);
            fea_vector(y, x, 1*34+1:2*34) = p(fix_to_range(y - 1, 1, y_max), x, :); % top
            fea_vector(y, x, 2*34+1:3*34) = p(fix_to_range(y + 1, 1, y_max), x, :); % bottom
            fea_vector(y, x, 3*34+1:4*34) = p(y, fix_to_range(x - 1, 1, x_max), :); % left (sub)
            fea_vector(y, x, 4*34+1:5*34) = p(y, fix_to_range(x + 1, 1, x_max), :); % right (add)

            fea_vector(y, x, 5*34+1:6*34)  = sum_patch(p, x, y, 3); % center
            fea_vector(y, x, 6*34+1:7*34)  = sum_patch(p, x, fix_to_range(y - 3, 1, y_max), 3); % top
            fea_vector(y, x, 7*34+1:8*34)  = sum_patch(p, x, fix_to_range(y + 3, 1, y_max), 3); % bottom
            fea_vector(y, x, 8*34+1:9*34)  = sum_patch(p, fix_to_range(x - 3, 1, x_max), y, 3); % left (sub)
            fea_vector(y, x, 9*34+1:10*34) = sum_patch(p, fix_to_range(x + 3, 1, x_max), y, 3); % right (add)

            fea_vector(y, x, 10*34+1:11*34) = sum_patch(p, x, y, 9); % center
            fea_vector(y, x, 11*34+1:12*34) = sum_patch(p, x, fix_to_range(y - 9, 1, y_max), 9); % top
            fea_vector(y, x, 12*34+1:13*34) = sum_patch(p, x, fix_to_range(y + 9, 1, y_max), 9); % bottom
            fea_vector(y, x, 13*34+1:14*34) = sum_patch(p, fix_to_range(x - 9, 1, x_max), y, 9); % left (sub)
            fea_vector(y, x, 14*34+1:15*34) = sum_patch(p, fix_to_range(x + 9, 1, x_max), y, 9); % right (add)

            fea_vector(y, x, 15*34+1:16*34) = sum_col(c, x, 1, original_patch_size);
            fea_vector(y, x, 16*34+1:17*34) = sum_col(c, x, 2, original_patch_size);
            fea_vector(y, x, 17*34+1:18*34) = sum_col(c, x, 3, original_patch_size);
            fea_vector(y, x, 18*34+1:19*34) = sum_col(c, x, 4, original_patch_size);
        end
    end
    toc(start)
end

function [ fixed ] = fix_to_range(num, min, max)
    fixed = num;
    if (num < min)
        fixed = min;
    end
    if (num > max)
        fixed = max;
    end
end

function [ fea_vector ] = sum_patch(p, x, y, patch_size)
    x_max = size(p, 2);
    y_max = size(p, 1);
    yupper = fix_to_range(y + patch_size - 1, 1, y_max);
    xupper = fix_to_range(x + patch_size - 1, 1, x_max);
    fea_vector = sum(sum(p(y:yupper, x:xupper, :)));
end

function [ fea_vector ] = sum_col(c, x, patch_no, patch_size)
    x_max = size(c, 2);
    x = fix_to_range((x-1)*patch_size+1, 1, x_max);
    xupper = fix_to_range(x + patch_size * 9 - 1, 1, x_max);
    fea_vector = sum(c(patch_no, x:xupper, :));
end