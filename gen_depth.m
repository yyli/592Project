function [gdepth, depth, fea_vector, lim] = gen_depth(suffix, theta)
    img = imread(strcat('img-', suffix, '.jpg'));
    load(strcat('depth_sph_corr-', suffix, '.mat'));
    depth = log(resize_depth(Position3DGrid(:, :, 4), 213, 284));
    fea_vector = generate_all_image_features(img);
    gdepth = inference_depth(fea_vector, theta);
    lim = [min(min(depth)) max(max(depth))];
    maxd = max(max(depth));
    maxgd = max(max(gdepth));
    normd = max([maxgd maxd]);
    subplot(1, 4, 3), imshow(gdepth/normd, 'Colormap', jet(255))%imagesc(gdepth, lim)
    title('Generated')
    subplot(1, 4, 2), imshow(depth/normd, 'Colormap', jet(255))%imagesc(depth, lim)
    title('Truth')
    subplot(1, 4, 4), imshow(abs(gdepth-depth)/max(max(abs(gdepth-depth))), 'Colormap', jet(255))%imagesc(abs(gdepth-depth))
    title('Abs Diff')
    subplot(1, 4, 1), imshow(img);
    title('Image')
end