function para = para_multi(ts)
% Computes parameters for pdf_multi which assumes multivariate normal distribution
% ts training set (sample = row; the first column contains labels)
% para - structure containing parameters:
%	para.labels - class labels
%	para.mu - features' mean values (row per class)
%	para.sig - features' covariance matrices (LAYER per class)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(columns(ts)-1, columns(ts)-1, rows(labels));

	for clid = 1:rows(labels)
		para.mu(clid, :) = mean(ts(ts(:,1) == labels(clid), 2:end));
		para.sig(:, :, clid) = cov(ts(ts(:,1) == labels(clid), 2:end));
				%^^^^^^^^^^ watch this!
	end
end