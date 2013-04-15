function [diff] = calc_mean()
    folder = 'Testresults/depth/';
	listing = dir(folder);
	numfiles = size(listing, 1) - 2;
    x_max = 213;
    y_max = 284;
    diff = zeros(1, numfiles);
    for i = 1:numfiles,
        % disp(listing(i+2).name);
        load(strcat('depth_sph_corr-', listing(i+2).name));
        depth = log(resize_depth(Position3DGrid(:, :, 4), x_max, y_max));
        load(listing(i+2).name);
        absd = mean(mean(abs(depth-gdepth)));
        diff(i) = absd;
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
    diff;
    mean(diff)
    exp(mean(diff))
end