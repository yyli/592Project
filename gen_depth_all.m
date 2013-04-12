function [] = gen_depth_all(theta)
    folder = 'Test134Img';
	listing = dir(folder);
	numfiles = size(listing, 1) - 2;
    for i = 1+92:numfiles,
        disp(listing(i+2).name);
        img = imread(listing(i+2).name);
        load(strcat('depth_sph_corr-', listing(i+2).name(1+4:end-4), '.mat'));
        depth = log(resize_depth(Position3DGrid(:, :, 4), 213, 284));
        fea_vector = generate_all_image_features(img);
        gdepth = inference_depth(fea_vector, theta);
        save(strcat('Testresults/depth/', listing(i+2).name(1+4:end-4), '.mat'), 'gdepth', '-v7.3');
%         lim = [min(min(depth)) max(max(depth))];
%         maxd = max(max(depth));
%         maxgd = max(max(gdepth));
%         normd = max([maxgd maxd]);
%         h=figure('visible','off');
%         subplot(1, 4, 3), imshow(gdepth/normd, 'Colormap', jet(255))%imagesc(gdepth, lim)
%         title('Generated')
%         subplot(1, 4, 2), imshow(depth/normd, 'Colormap', jet(255))%imagesc(depth, lim)
%         title('Truth')
%         subplot(1, 4, 4), imshow(abs(gdepth-depth)/max(max(abs(gdepth-depth))), 'Colormap', jet(255))%imagesc(abs(gdepth-depth))
%         title('Abs Diff')
%         subplot(1, 4, 1), imshow(img);
%         title('Image')
%         saveas(h, strcat('testresults/result-', listing(i+2).name(1+4:end-4), '.jpg'), 'jpg');
%         close(h);
    end
end