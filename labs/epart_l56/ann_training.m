% read dataset, show and correct labels
[tvec tlab tstv tstl] = readSets(); 
[unique(tlab)'; unique(tstl)']
tlab += 1;
tstl += 1;

###               EXPLORATION 
##dist=[];
##for lab=1:rows(unique(tlab))
##  lab;
##  dist(lab)=[sum((tlab==lab),1)/rows(tlab)];
##end
##disp("TRAIN DISTR")
##lab
##dist
##plot(1:1:rows(unique(tlab)),dist, "*")
##
##hold on;
##
##for lab=1:rows(unique(tstl))
##  lab;
##    dist(lab)=[sum((tstl==lab),1)/rows(tstl)];
##end
##
##plot(1:1:rows(unique(tstl)),dist, "+")
##disp("Test DISTR")
##lab
##dist


#=====================================================================================
#=====================================================================================
#=====================================================================================
#NORMALIZATION
mu = mean(tvec);
sig = std(tvec);
# scale and center
tvec = (tvec - mu).* (1./sig);
tstv = (tstv - mu).* (1./sig);

#=====================================================================================
#=====================================================================================
#=====================================================================================

noHiddenNeurons = 100;
noEpochs = 19;
learningRate = 0.001;
numberClasses= 10;

% to get and save the rnd state generator use these three lines
##rand()
##rstate = rand("state");#vector of few hundread number given
##save rnd_state.txt rstate

# LOADING SEED
% to load saved rnd state use these three lines
 rand()
 load rnd_state.txt 
 rand("state", rstate);



[hlnn olnn] = crann(columns(tvec), noHiddenNeurons, numberClasses);
trainError = zeros(1, noEpochs);
testError = zeros(1, noEpochs);
trReport = [];

for epoch=1:noEpochs
	tic();
  #resets internal time counter of octave
  #toc produces time needed to execute backprop, classific to create confusion matrix
  #cerco di non classificare nulla con backprop
  
	[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, learningRate); #NORMAL ONE
  #[hlnn olnn terr] = backprop_inv_drop(tvec, tlab, hlnn, olnn, learningRate); #WITH DROP OUT
  
	clsRes = anncls(tvec, hlnn, olnn);
  
	cfmx = confMx(tlab, clsRes);
  
	errcf = compErrors(cfmx);
  
	trainError(epoch) = errcf(2);
  
#----------------------------------------------------------

	clsRes = anncls(tstv, hlnn, olnn);
  
	cfmx = confMx(tstl, clsRes);
  
	errcf2 = compErrors(cfmx);
  
	testError(epoch) = errcf2(2);
#-----------------------------------------------------------
  
	epochTime = toc();
  
	disp([epoch epochTime trainError(epoch) testError(epoch)])
  
	trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
  
############################################################
  #INCREMENTAL PHASE IN WHICH I FIND THE BIGGEST LEARNING RATE WITHOUT INVERTED BEH
##  learningRate= learningRate + 0.001;
##  learningRate
##  if epoch>1
##    if terr > previousTerr
##      BIG_ENOUGH= epoch
##    endif
##  endif
##  prevERR= terr;
##############################################################
#######################################################
#       DECREMENTING
##learningRate=learningRate-0.00005;
##learningRate
######################################################
	fflush(stdout);  
end


# plot trainE and testE
x=1:rows(trReport)
plot(x,trainError,x,testError)



#confusion matrix of last test 
cfmx

