function [Err ovrsp] = trainOVRensamble(tset, tlab, htrain)
% Trains a set of linear classifiers (one versus rest class)
% on the training set using trainSelect function
% tset - training set samples
% tlab - labels of the samples in the training set
% htrain - handle to proper function computing separating plane
% ovrsp - one versus rest class linear classifiers matrix
%   the first column contains positive class label
%   the second column contains negative class label
%   columns (3:end) contain separating plane coefficients

  labels = unique(tlab);
  clfnumb=rows(labels);
  ovrsp = zeros(clfnumb, 2+1+ columns(tset));
  
  Err = zeros(clfnumb,1);
  
  for i=1:clfnumb
	% store labels in the first two columns
    ovrsp(i, 1:2) = [labels(i) 0];
	
	% select samples of two digits from the training set
    posSamples = tset(tlab == labels(i), :);
    negSamples = tset(tlab ~= labels(i), :);
	
	% train 5 classifiers and select the best one
    [sp fp fn] = trainSelect(posSamples, negSamples, 5, htrain);

    ovrsp(i, 3:end) = sp;
    Err(i)= (fp+fn)/(rows(posSamples)+rows(negSamples));
##    clfnumb;
##    fp;
##    fn;
  end
  
