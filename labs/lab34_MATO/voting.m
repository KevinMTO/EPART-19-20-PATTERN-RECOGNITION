function votes = voting(tset, clsmx)
% tset - matrix containing test data; one row represents one sample
% clsmx - voting committee matrix
%	clsmx(:,1) contains positive class label
%	clsmx(:,2) contains negative class label
%	clsmx(:,3) is "augmented dimension" coefficient (bias of sep. hyperplane)
%	clsmx(:,4:end) are regular separating hyperplane coefficients
% votes - output matrix of votes cast by all one-versus-one classifiers

	% get column vector of all positive labels present in the first two columns 
	% of voting committee 
	labels = unique(clsmx(:,1:2)(:));

	% prepare voting result
	votes = zeros(size(tset,1), size(labels,1));

	% prepare "augmented dimension" coordinate - column of "1"
	aone = ones(size(tset,1), 1);
	
	% for all individual classifiers
	for i=1:size(clsmx,1)
		% get response of one ovo classifier for all samples
		res = [aone tset] * clsmx(i,3:end)';

		% find index of positive label of this classifier
		pid = find(labels == clsmx(i,1));

		% for all samples that produced non-negative response 
		%   increase number of votes for positive class by one
		votes(res >= 0, pid) += 1;

		% find index of positive label of this classifier
		nid = find(labels == clsmx(i,2));

		% for all samples that produced negative response 
		%   increase number of votes for negative class by one
		votes(res < 0, nid) += 1;
	end
