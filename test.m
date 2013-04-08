function [ theta ] = test()
	start = tic;
	max_rows = 284;
	theta = zeros(646, 284);
	for r = 1:max_rows,
		tic
		feature_row = [];
		depth_row = [];
		for i = 1:10,
			imgfile = matfile(strcat('ParsedImg/', int2str(i), '.mat'));
			depthfile = matfile(strcat('ParsedDepth/', int2str(i), '.mat'));
			feature_row = [feature_row; squeeze(imgfile.fea_vector(r, :, :))];
			depth_row = [depth_row; squeeze(depthfile.depth(r, :))'];
			% load(strcat('ParsedImg/', int2str(i), '.mat'));
			% load(strcat('ParsedDepth/', int2str(i), '.mat'));
			% feature_row = [feature_row; squeeze(fea_vector(r, :, :))];
			% depth_row = [depth_row; squeeze(depth(r, :))'];
		end
		depth_row = log(depth_row);
		% size(feature_row)
		% size(depth_row)
		% toc(start)
		toc
		theta(:, r) = train_depth(feature_row, depth_row);
		midend = toc;
		fprintf('mean diff: %12.9f time: %10.6f\n',mean(abs(feature_row*theta(:, r) - depth_row)), midend)
	end
	toc(start)
end