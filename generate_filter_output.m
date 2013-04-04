function [ img_vector ] = generate_filter_output(img)
    Law1 = [1 2 1; 2 4 2; 1 2 1];
    Law2 = [-1 0 1; -2 0 2; -1 0 1];
    Law3 = [-1 2 -1; -2 4 -2; -1 2 -1];
    Law4 = [-1 -2 -1; 0 0 0; 1 2 1];
    Law5 = [1 0 -1; 0 0 0 ; -1 0 1];
    Law6 = [1 -2 1; 0 0 0; -1 2 -1];
    Law7 = [-1 -2 -1; 2 4 2; -1 -2 -1];
    Law8 = [1 0 -1; -2 0 2; 1 0 -1];
    Law9 = [1 -2 1; -2 4 -2; 1 -2 1];
    Edge1 = [-2 -2 0 2 2; -2 -2 0 2 2; -2 -2 0 2 2; -2 -2 0 2 2; -2 -2 0 2 2];
    Edge2 = [-2 1 2 2 2; -2 -2 2 2 2; -2 -2 0 2 2; -2 -2 -2 2 2; -2 -2 -2 -1 2];
    Edge3 = [2 2 2 2 2; -1 2 2 2 2; -2 -2 -1 2 2; -2 -2 -2 -2 1; -2 -2 -2 -2 -2];
    Edge4 = Edge1';
    Edge5 = Edge2';
    Edge6 = Edge3';

    img = im2double(img);
    img = rgb2ycbcr(img);

    img_vector = zeros(size(img, 1), size(img, 2), 17);

    img_vector(:, :, 1)  = abs(conv2(img(:,:,1), Law1, 'same'));
    img_vector(:, :, 2)  = abs(conv2(img(:,:,1), Law2, 'same'));
    img_vector(:, :, 3)  = abs(conv2(img(:,:,1), Law3, 'same'));
    img_vector(:, :, 4)  = abs(conv2(img(:,:,1), Law4, 'same'));
    img_vector(:, :, 5)  = abs(conv2(img(:,:,1), Law5, 'same'));
    img_vector(:, :, 6)  = abs(conv2(img(:,:,1), Law6, 'same'));
    img_vector(:, :, 7)  = abs(conv2(img(:,:,1), Law7, 'same'));
    img_vector(:, :, 8)  = abs(conv2(img(:,:,1), Law8, 'same'));
    img_vector(:, :, 9)  = abs(conv2(img(:,:,1), Law9, 'same'));
    img_vector(:, :, 10) = abs(conv2(img(:,:,2), Law1, 'same'));
    img_vector(:, :, 11) = abs(conv2(img(:,:,3), Law1, 'same'));
    img_vector(:, :, 12) = abs(conv2(img(:,:,1), Edge1, 'same'));
    img_vector(:, :, 13) = abs(conv2(img(:,:,1), Edge2, 'same'));
    img_vector(:, :, 14) = abs(conv2(img(:,:,1), Edge3, 'same'));
    img_vector(:, :, 15) = abs(conv2(img(:,:,1), Edge4, 'same'));
    img_vector(:, :, 16) = abs(conv2(img(:,:,1), Edge5, 'same'));
    img_vector(:, :, 17) = abs(conv2(img(:,:,1), Edge6, 'same'));
end