function clab = unamvoting(tset, clsmx)
% Simple unanimity voting function 
% 	tset - matrix containing test data; one row represents one sample
% 	clsmx - voting committee matrix
% Output:
%	clab - classification result 

	% class processing
	labels = unique(clsmx(:, [1 2]));
	reject = max(labels) + 1;

	% cast votes of classifiers
	votes = voting(tset, clsmx);

	maxvotes = rows(labels) - 1; % unanimity voting in one vs. one scheme

	[mv clab] = max(votes, [], 2);

	% reject decision 
	clab(mv ~= maxvotes) = reject;
