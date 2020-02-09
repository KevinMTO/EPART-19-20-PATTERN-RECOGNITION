% read dataset, show and correct labels
[tvec tlab tstv tstl] = readSets(); 
[unique(tlab)'; unique(tstl)']
tlab += 1;
tstl += 1;

#=====================================================================================
#NORMALIZATION
mu = mean(tvec);
sig = std(tvec);
# scale and center
tvec = (tvec - mu).* (1./sig);
tstv = (tstv - mu).* (1./sig);
#=====================================================================================

noHiddenNeurons = 100;
noEpochs = 50;
learningRate = 0.001;
numberClasses= 10;

# LOADING SEED
% to load saved rnd state use these three lines
 rand()
 load rnd_state.txt 
 rand("state", rstate);


[hlnn1 hlnn2 olnn] = crann2layer(columns(tvec), noHiddenNeurons, numberClasses);
trainError = zeros(1, noEpochs);
testError = zeros(1, noEpochs);
trReport = [];



for epoch=1:noEpochs
	tic();
  #resets internal time counter of octave
  #toc produces time needed to execute backprop, classific to create confusion matrix
  #cerco di non classificare nulla con backprop
  
	#[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, learningRate); #NORMAL ONE
  [hidlw1 hidlw2 olnn terr] = backprop2layer(tvec, tlab, hlnn1,hlnn2, olnn, learningRate); #WITH DROP OUT
  
	clsRes = anncls2layer(tvec, hidlw1, hidlw2, olnn);
  
	cfmx = confMx(tlab, clsRes);
  
	errcf = compErrors(cfmx);
  
	trainError(epoch) = errcf(2);
  
#----------------------------------------------------------

	clsRes2 = anncls2layer(tstv, hidlw1, hidlw2, olnn);
  
	cfmx = confMx(tstl, clsRes2);
  
	errcf2 = compErrors(cfmx);
  
	testError(epoch) = errcf2(2);
#-----------------------------------------------------------
  
	epochTime = toc();
  
	disp([epoch epochTime trainError(epoch) testError(epoch)])
  
	trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
  
	fflush(stdout);
  
end


# plot trainE and testE
x=1:rows(trReport)
plot(x,trainError,x,testError)

#confusion matrix of last test 
cfmx

