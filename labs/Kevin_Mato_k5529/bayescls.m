function decv = bayescls(samples, pdfunc, pdparams, apriori)
% Bayes classifier
% samples - matrix of samples to be classified (sample is a row of the matrix; there's no labels column)
% pdfunc - handle to probability density function
% pdparams - a structure containing parameters for pdfunc
% apriori (optional) - row vector of a priori probabilities
% decv - column vector of labels (bayes classifiers' decision)

	pdfs = pdfunc(samples, pdparams);
	
	% a priori taken into account only if specified by caller
	if nargin >= 4
		pdfs .*= repmat(apriori, rows(pdfs), 1);
	end
	
	% we don't need a posteriori probability value
	[~, mi] = max(pdfs, [], 2);
	
	% class number -> label translation
	decv = pdparams.labels(mi);

end
