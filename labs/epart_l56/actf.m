function res = actf(tact)
% sigmoid activation function
% tact - total activation 
#da implementare
	
  #BIPOLAR CONTINOUS SIGMOIDAL LAMBDA 1
  res= [(2 ./ (1 + e.^-tact))-ones(size(tact))];

  
  #per il testing
##  x= -5:0.1:5
##  plot(x,actf(x))
  #posso usare simoid o rect lin unit
  #e decidere se unip o bipolar
  #la cost function deve essere un pochino diversa dalle lezioni