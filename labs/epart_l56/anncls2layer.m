function lab = anncls2layer(tset, hidlw1, hidlw2, outlw)
% simple ANN classifier
% tset - data to be classified (every row represents a sample) 
% hidlw1 - hidden layer 1 weight matrix
% hidlw2 - hidden layer 2 weight matrix
% outlw - output layer weight matrix

#tset manca di una colonna di uni dovuti al bias perchè dovremo moltiplicare con i bias
#devo appendere una colonna di uni

#il risultato con colonne numero neru, e rows sampples che è la total activation
#poi ci devo applicare la activation function sulla matrice appena ottenuta

% lab - classification result (index of output layer neuron with highest value)
% ATTENTION: we assume that constant value IS NOT INCLUDED in tset rows
	hlact1 = [tset ones(rows(tset), 1)] * hidlw1;
	hlout1 = actf(hlact1);
  
  hlact2 = [hlout1 ones(rows(hlout1), 1)] *hidlw2;
	hlout2 = actf(hlact2);
  
	olact = [hlout2 ones(rows(hlout2), 1)] * outlw;
	olout = actf(olact);
	
	[~, lab] = max(olout, [], 2);
