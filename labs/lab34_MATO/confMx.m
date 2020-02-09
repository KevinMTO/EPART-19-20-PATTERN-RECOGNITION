function cfmx = confMx(truelab, declab)
% Computes confusion matrix cfmx given
% 	truelab - column vector of ground-truth labels
% 	declab - column vector of classifiers decisions
% Output:
% 	cfmx - confusion matrix:
%		rows - are for ground truth
%		columns - are for classfier output
% It's assumed that rejection decision is coded as max(labels)+1

  labels = unique(truelab);
  cfmx = zeros(rows(labels), rows(labels) +1);
  for i = 1:rows(truelab)
    cfmx(truelab(i), declab(i)) += 1;
  end
