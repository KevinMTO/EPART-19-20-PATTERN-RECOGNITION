function [sp fp fn] = trainSelect(posc, negc, reps, htrain)
% Performs learning of the linear classifier (reps) times
% and selects the best classifier
% 	posc - samples of class which should be on the positive side of separating plane
% 	negc - samples of class which should be on the negative side of separating plane
% 	reps - number of repetitions of training
% 	htrain - handle to function computing separating plane
% Output:
% sp - coefficients of the best separating plane
% fp - false positive count (i.e. number of misclassified samples of pclass)
% fn - false negative count (i.e. number of misclassified samples of nclass)

  manysp = zeros(reps, 1 + columns(posc));
  fPos = zeros(reps, 1);
  fNeg = zeros(reps, 1);
  
  for i=1:reps
    [manysp(i,:) fPos(i) fNeg(i)] = htrain(posc, negc);
  end
  [errCnt theBestIdx] = min(fPos + fNeg);
  sp = manysp(theBestIdx, :);
  fp = fPos(theBestIdx);
  fn = fNeg(theBestIdx);
