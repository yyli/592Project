function [] = fix_saves()
	start = tic;
	max_rows = 284;
	for i = 1:134,
		tic
		load(strcat('ParsedTestImg/', int2str(i), '.mat'));
		for r = 1:max_rows,
			row = squeeze(fea_vector(r, :, :));
			save(strcat('ParsedTestImg/rowbyrow/', int2str(i), '-', int2str(r), '.mat'), 'row', '-v7.3');
		end
		toc
	end
	toc(start)
end