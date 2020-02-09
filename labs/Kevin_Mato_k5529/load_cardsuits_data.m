function [train, test] = load_cardsuits_data()
% Loads the training and testing sets containing card suits data
% Labels are remapped from 1-4 to 1-8 to take into account different printing
% Data files should be in the current working directory

% now you can start work with cards!
load train.txt
load test.txt

% because our data contains really samples from two populations
% we replace "client" labels with labels more suitable for classification
for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end
