function para = para_indep(ts)
% Computes parameters for pdf_indep which assumes features are independent
% ts training set (sample = row; the first column contains labels)
% para - structure containing parameters:
%	para.labels - class labels
%	para.mu - features' mean values (row per class)
%	para.sig - features' standard deviations (row per class)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(rows(labels), columns(ts)-1);

	for clid = 1:rows(labels)
		para.mu(clid, :) = mean(ts(ts(:,1) == labels(clid), 2:end));
		para.sig(clid, :) = std(ts(ts(:,1) == labels(clid), 2:end));
	end
end