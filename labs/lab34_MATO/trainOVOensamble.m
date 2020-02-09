function [Err ovosp] = trainOVOensamble(tset, tlab, htrain)
% Trains a set of linear classifiers (one versus one class)
% on the training set using trainSelect function
% tset - training set samples
% tlab - labels of the samples in the training set
% htrain - handle to proper function computing separating plane
% ovosp - one versus one class linear classifiers matrix
%   the first column contains positive class label
%   the second column contains negative class label
%   columns (3:end) contain separating plane coefficients

  labels = unique(tlab);
  
  % nchoosek produces all possible unique pairs of labels
  % that's exactly what we need for ovo classifier
  pairs = nchoosek(labels, 2);
  ovosp = zeros(rows(pairs), 2 + 1 + columns(tset));
  Er = zeros(rows(pairs),1);
  
  for i=1:rows(pairs)
	% store labels in the first two columns
    ovosp(i, 1:2) = pairs(i, :);
	
	% select samples of two digits from the training set
    posSamples = tset(tlab == pairs(i,1), :);
    negSamples = tset(tlab == pairs(i,2), :);
	
	% train 5 classifiers and select the best one
    [sp fp fn] = trainSelect(posSamples, negSamples, 5, htrain);
	
	% what to do with errors?
	% it would be wise to add additional output argument
	% to return error coefficients
	
    % store the separating plane coefficients (this is our classifier)
	% in ovo matrix
    ovosp(i, 3:end) = sp;
    Er(i)=(fp+fn)/(rows(posSamples)+rows(negSamples)) ;
##    pairs(i, :);
##    fp;
##    fn;
  end
  output_precision(10)
  Err=[ovosp(:,1:2) Er ]
