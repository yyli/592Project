function [ theta ] = test()
	start = tic;
	max_rows = 284;
	max_col = 213;
	theta = zeros(646, 284);
	for r = 1:max_rows,
		midstart = tic;
		feature_row = zeros(213*400, 646);
		depth_row = zeros(213*400, 1);
		for i = 1:400,
			% tic
			load(strcat('ParsedImg/rowbyrow/', int2str(i), '-', int2str(r), '.mat'));
			% imgfile = matfile(strcat('ParsedImg/', int2str(i), '.mat'));
			depthfile = matfile(strcat('ParsedDepth/', int2str(i), '.mat'));
			% feature_row = [feature_row; squeeze(imgfile.fea_vector(r, :, :))];
			% depth_row = [depth_row; squeeze(depthfile.depth(r, :))'];
			% feature_row((i-1)*213+1:i*213, :) = squeeze(imgfile.fea_vector(r, :, :));
			% depth_row((i-1)*213+1:i*213, :) = squeeze(depthfile.depth(r, :))';
			feature_row((i-1)*213+1:i*213, :) = squeeze(row);
			depth_row((i-1)*213+1:i*213, :) = squeeze(depthfile.depth(r, :))';
			% toc
			% load(strcat('ParsedImg/', int2str(i), '.mat'));
			% load(strcat('ParsedDepth/', int2str(i), '.mat'));
			% feature_row = [feature_row; squeeze(fea_vector(r, :, :))];
			% depth_row = [depth_row; squeeze(depth(r, :))'];
		end
		depth_row = log(depth_row);
		% size(feature_row)
		% size(depth_row)
		% toc(start)
		% toc(midstart)
		theta(:, r) = train_depth(feature_row, depth_row);
		midend = toc(midstart);
		fprintf('mean diff: %12.9f time: %10.6f percent: %8.4f\n', mean(abs(feature_row*theta(:, r) - depth_row)), midend, r/max_rows*100)
		% fprintf('time: %10.6f percent: %8.4f\n', midend, r/max_rows*100)
	end
	toc(start)
end