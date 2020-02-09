function [hidlw outlw terr] = backprop(tset, tlab, inihidlw, inioutlw, lr)
% derivative of sigmoid activation function
% tset - training set (every row represents a sample)
% tslb - column vector of labels 
% inihidlw - initial hidden layer weight matrix
% inioutlw - initial output layer weight matrix
% lr - learning rate

% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix
% terr - total squared error of the ANN
% delta_hlw_tminus1 - modification of weights hidden at t-1
% delta_olw_tminus1 - modification of weights out at t-1
% mu- momentum factor

  
% 1. Set output matrices to initial values
	hidlw = inihidlw;
	outlw = inioutlw;
  
  
  delta_hlw_tminus1= zeros(rows(inihidlw),columns(inihidlw));
  delta_olw_tminus1= zeros(rows(inioutlw),columns(inioutlw));
	
% 2. Set total error to 0
	terr = 0;
#------------------------------------------------------------- 
##shuffling of samples (unnoticeble changes)
##  shuffling = randperm(rows(tset));
##  tset= tset(shuffling,:);
##  tlab= tlab(shuffling,:);
#---------------------------------------------------------------
  
% foreach sample in the training set
	for i=1:rows(tset)
    
		% 3. Set desired output of the ANN
          
          bipolar = -1 * ones(1, columns(outlw)); #BIPOLAR
          #unipolar = zeros(1, columns(outlw)); #UNIPOLAR
          #If changing to unipolar need to change actf
          
		      desired_output = bipolar; #BIPOLAR
          #desired_output = unipolar; #UNIPOLAR
##        desired_output= desired_output(:,tlab(i,:))=1; for studying purpose

          desired_output(tlab(i)) = 1;
		% 4. Propagate input forward through the ANN
    
          total_net_hl= [tset(i,:) 1]*hidlw;
          out_hl= actf(total_net_hl); #BIPOLAR
          #out_hl= actfu(total_net_hl); #UNIPOLAR
          
          total_net_o= [out_hl 1]*outlw;
          out_o= actf(total_net_o); #BIPOLAR
          #out_o= actfu(total_net_o); #UNIPOLAR

          
		% 5. Adjust total error
    
		      terr= terr + sum(0.5*(desired_output - out_o).^2);
          
		% 6. Compute delta error of the output layer
    
         error_o= (desired_output - out_o);
         delta_o= error_o .*actdf(out_o); #BIPOLAR
         #delta_o= error_o .*actfudf(out_o); #UNIPOLAR
		
		% 7. Compute delta error of the hidden layer
    
		     error_hl= delta_o * outlw(1:end-1,:)';
         delta_hl= error_hl .* actdf(out_hl); #BIPOLAR
         #delta_hl= error_hl .* actfudf(out_hl); #UNIPOLAR
         
    % 7' Compute gradient
         delta_W_out_t= lr * [out_hl 1]' * delta_o;
         delta_W_hl_t = lr * [tset(i,:) 1]' *delta_hl;
         
		% 8. Update output layer weights
         
         mu = 1-lr;
         
         #outlw= outlw + delta_W_out_t;
         outlw= outlw + delta_W_out_t + mu*delta_olw_tminus1; #WITH MOMENTUM
         
		
		% 9. Update hidden layer weights
         #hidlw = hidlw + delta_W_hl_t;
         hidlw = hidlw + delta_W_hl_t + mu* delta_hlw_tminus1; #WITH MOMENTUM
         
    %9'  Update momentum
         delta_hlw_tminus1= delta_W_hl_t;
         delta_olw_tminus1= delta_W_out_t;
         
	end
