function label = cls1nn(x, ts)
% 1-NN classfier 
% ts - training set; the first column contains class label
% x - sample to be classified; no label here!
% label - labels of x's nearest neighbour in ts
  sqdist = sumsq(bsxfun(@minus, ts(:,2:end), x), 2);
  [v, iv] = min(sqdist);
  label = ts(iv,1);
