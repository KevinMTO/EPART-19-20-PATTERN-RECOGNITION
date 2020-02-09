function [hidlw1 hidlw2 outlw terr] = backprop2layer(tset, tlab, inihidlw1, inihidlw2, inioutlw, lr)
% derivative of sigmoid activation function
% tset - training set (every row represents a sample)
% tslb - column vector of labels 
% inihidlw - initial hidden layer weight matrix
% inioutlw - initial output layer weight matrix
% lr - learning rate

% hidlw1 - hidden layer 1 weight matrix
% hidlw2 - hidden layer 2 weight matrix
% outlw - output layer weight matrix
% terr - total squared error of the ANN
% delta_hlw_tminus1 - modification of weights hidden at t-1
% delta_olw_tminus1 - modification of weights out at t-1
% mu- momentum factor

  
% 1. Set output matrices to initial values
	hidlw1 = inihidlw1;
	hidlw2 = inihidlw2;
	outlw = inioutlw;
  
  
  delta_hlw1_tminus1= zeros(rows(inihidlw1),columns(inihidlw1));
  delta_hlw2_tminus1= zeros(rows(inihidlw2),columns(inihidlw2));
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
    
          total_net_hl= [tset(i,:) 1]*hidlw1;
          out_hl1= actf(total_net_hl); 
          
          total_net_hl= [out_hl1 1]*hidlw2;
          out_hl2= actf(total_net_hl);           
          #out_hl= actfu(total_net_hl); #UNIPOLAR
          
          total_net_o= [out_hl2 1]*outlw;
          out_o= actf(total_net_o); #BIPOLAR
          #out_o= actfu(total_net_o); #UNIPOLAR

          
		% 5. Adjust total error
    
		      terr= terr + sum(0.5*(desired_output - out_o).^2);
          
		% 6. Compute delta error of the output layer
    
         error_o= (desired_output - out_o);
         delta_o= error_o .*actdf(out_o); #BIPOLAR
         #delta_o= error_o .*actfudf(out_o); #UNIPOLAR
		
		% 7. Compute delta error of the hidden layer
    
		     error_hl2= delta_o * outlw(1:end-1,:)';
         delta_hl2= error_hl2 .* actdf(out_hl2);
         
         error_hl1= delta_hl2 * hidlw2(1:end-1,:)';
         delta_hl1= error_hl1 .* actdf(out_hl1); #BIPOLAR
         #delta_hl= error_hl .* actfudf(out_hl); #UNIPOLAR
         
    % 7' Compute gradient
         delta_W_out_t= lr * [out_hl2 1]' * delta_o;
         delta_W_hl1_t = lr * [tset(i,:) 1]' *delta_hl1;
         delta_W_hl2_t = lr * [out_hl1 1]' *delta_hl2;
         
		% 8. Update output layer weights
         
         mu = 1-lr;
         
         #outlw= outlw + delta_W_out_t;
         outlw= outlw + delta_W_out_t + mu*delta_olw_tminus1; #WITH MOMENTUM
         
		
		% 9. Update hidden layer weights
##        hidlw1 = hidlw1 + delta_W_hl1_t;
##        hidlw2 = hidlw2 + delta_W_hl2_t;
         
         hidlw1 = hidlw1 + delta_W_hl1_t + mu* delta_hlw1_tminus1; #WITH MOMENTUM
         hidlw2 = hidlw2 + delta_W_hl2_t + mu* delta_hlw2_tminus1; #WITH MOMENTUM
         
         
    %9'  Update momentum
         delta_hlw1_tminus1= delta_W_hl1_t;
         delta_hlw2_tminus1= delta_W_hl2_t;
         delta_olw_tminus1= delta_W_out_t;
         
	end
