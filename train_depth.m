function [ theta ] = train_depth(features, depth)
	% feature_row = squeeze(features(row, :, :));
	% feature_row = [squeeze(features(row, :, :)); squeeze(features(row+1, :, :)); squeeze(features(row+2, :, :)); squeeze(features(row+3, :, :))];
	% depth_row = log(squeeze(depth(row, :)))';
	% depth_row = log([squeeze(depth(row, :))'; squeeze(depth(row+1, :))'; squeeze(depth(row+2, :))'; squeeze(depth(row+3, :))']);
	% size(feature_row);
	% size(depth_row);

	% theta3 = pinv(feature_row) * depth_row;
	% theta = robustfit(features, depth, 'huber', 1.345, 'off');
	theta = regress(depth, features);
	% [feature_row*theta feature_row*theta2 feature_row*theta3 depth_row];
end