function res = actfu(tact)
% sigmoid activation function
% tact - total activation 
#UNIPOLAR
  res = 1./(1 + exp (-tact));
