function clab = OVRclassifier(tset, clsmx)
% Simple unanimity voting function 
% 	tset - matrix containing test data; one row represents one sample
% 	clsmx - voting committee matrix
% Output:
%	clab - classification result 


	labels = unique(clsmx(:, 1));
  
	reject = max(labels) + 1;

  votes = OVRvoting(tset, clsmx);

  valids = sum(votes,2) ==1;

  decisions = votes .*valids;

  [mv clab]= max(decisions,[],2);
  
  clab(mv~=1)=reject;
  
  clab;
