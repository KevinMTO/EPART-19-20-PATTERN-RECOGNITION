function [hl ol] = crann(cfeat, chn, cclass)
% generates hidden and output ANN weight matrices
% cfeat - number of features 
% chn - number of neurons in the hidden layer
% cclass - number of neurons in the outpur layer (= number of classes)

% hl - hidden layer weight matrix
% ol - output layer weight matrix

% ATTENTION: we assume that constant value IS NOT INCLUDED

	hl = (rand(cfeat + 1, chn) - 0.5) / sqrt(cfeat + 1);#number of features + 1 rows, #neu columns
	ol = (rand(chn + 1, cclass) - 0.5) / sqrt(chn + 1);
  
  
  
  
#last row bias hl
#initial normalization of weights?????????
#near zero values where activation functins is 0
#quick training at first and slower later on

#ol
#last row again has biases