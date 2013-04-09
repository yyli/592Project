function [] = fix_saves()
	start = tic;
	max_rows = 284;
	for i = 1:400,
		tic
		load(strcat('ParsedImg/', int2str(i), '.mat'));
		for r = 1:max_rows,
			row = squeeze(fea_vector(r, :, :));
			save(strcat('ParsedImg/rowbyrow/', int2str(i), '-', int2str(r), '.mat'), 'row', '-v7.3');
		end
		toc
	end
	toc(start)
end