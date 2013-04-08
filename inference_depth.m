function [ depth ] = inference_depth(fea_vector, thetas)
	depth = zeros(284, 213);
	for r = 1:284
		depth(r, :) = thetas(:, r)' * squeeze(fea_vector(r, :, :))';
	end
end