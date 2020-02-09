function res = actfudf(tact)
% DERIVATIVE OF sigmoid UNIPOLAR activation function
% tact - total activation 
#UNIPOLAR BETA 
res = tact .* (1 - tact); 
