function para = para_parzen(ts, width = 0.0001)
% Computes parameters for pdf_parzen
% ts training set (sample = row; the first column contains labels)
% width - Parzen window width
% para - structure containing parameters:
%	para.labels - class labels
%	para.samples - cell array containing class samples
%	para.parzenw - Parzen window width

	labels = unique(ts(:,1));
	para.labels = labels;
	para.samples = cell(rows(labels),1);
	para.parzenw = width;

	for clid=1:rows(labels)
		para.samples{clid} = ts(ts(:,1) == labels(clid), 2:end);
				  % ^    ^ note cell array indexing
	end
end