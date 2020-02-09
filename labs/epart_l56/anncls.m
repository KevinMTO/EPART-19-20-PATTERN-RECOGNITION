function lab = anncls(tset, hidlw, outlw)
% simple ANN classifier
% tset - data to be classified (every row represents a sample) 
% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix

#tset manca di una colonna di uni dovuti al bias perchè dovremo moltiplicare con i bias
#devo appendere una colonna di uni

#il risultato con colonne numero neru, e rows sampples che è la total activation
#poi ci devo applicare la activation function sulla matrice appena ottenuta

% lab - classification result (index of output layer neuron with highest value)
% ATTENTION: we assume that constant value IS NOT INCLUDED in tset rows

	hlact = [tset ones(rows(tset), 1)] * hidlw;
	hlout = actf(hlact);
	
	olact = [hlout ones(rows(hlout), 1)] * outlw;
	olout = actf(olact);
	
	[~, lab] = max(olout, [], 2);#classific decision voglio solo la posizione e non il valore
