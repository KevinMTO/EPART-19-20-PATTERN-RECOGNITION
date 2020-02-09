pkg load statistics
clear all
clc
############################### INTRODUCTION ################################
############################### INTRODUCTION ################################
############################### INTRODUCTION ################################
############################### INTRODUCTION ################################
############################### INTRODUCTION ################################
################################   SKIP     #################################
################################   SKIP     #################################
################################   SKIP     #################################
################################   SKIP     #################################
########
######################################################% tiny data file to verify pdf functions
######################################################load pdf_test.txt
######################################################size(pdf_test)
######################################################
######################################################% how many classes are there?
######################################################labels = unique(pdf_test(:,1))
######################################################
######################################################% how many samples are in each class?
######################################################[labels'; sum(pdf_test(:,1) == labels')]
######################################################
######################################################
######################################################% what's the layout of the samples?
######################################################plot2features(pdf_test, 2, 3)
######################################################
######################################################pdfindep_para = para_indep(pdf_test)
######################################################% para_indep indep is already implemented; it should give:
######################################################
######################################################% pdfindep_para =
######################################################%  scalar structure containing the fields:
######################################################%    labels =
######################################################%       1
######################################################%       2
######################################################%    mu =
######################################################%       0.7970000   0.8200000
######################################################%      -0.0090000   0.0270000
######################################################%    sig =
######################################################%       0.21772   0.19172
######################################################%       0.19087   0.27179
######################################################
######################################################% now you have to implement pdf_indep 
######################################################pi_pdf = pdf_indep(pdf_test([2 7 12 17],2:end), pdfindep_para)
######################################################
######################################################%pi_pdf =
######################################################%  1.4700e+000  4.5476e-007
######################################################%  3.4621e+000  4.9711e-005
######################################################%  6.7800e-011  2.7920e-001
######################################################%  5.6610e-008  1.8097e+000
######################################################
######################################################% multivariate normal distribution - parameters ...
######################################################
######################################################pdfmulti_para = para_multi(pdf_test)
######################################################
######################################################%pdfmulti_para =
######################################################%  scalar structure containing the fields:
######################################################%    labels =
######################################################%       1
######################################################%       2
######################################################%    mu =
######################################################%       0.7970000   0.8200000
######################################################%      -0.0090000   0.0270000
######################################################%    sig =
######################################################%    ans(:,:,1) =
######################################################%       0.047401   0.018222
######################################################%       0.018222   0.036756
######################################################%    ans(:,:,2) =
######################################################%       0.036432  -0.033186
######################################################%      -0.033186   0.073868  
######################################################
######################################################% ... and probability density function (use mvnpdf in pdf_multi)
######################################################pm_pdf = pdf_multi(pdf_test([2 7 12 17],2:end), pdfmulti_para)
######################################################
######################################################%pm_pdf =
######################################################%  7.9450e-001  6.5308e-017
######################################################%  3.9535e+000  3.8239e-013
######################################################%  1.6357e-009  8.6220e-001
######################################################%  4.5833e-006  2.8928e+000
######################################################
######################################################% parameters for Parzen window approximation 
######################################################pdfparzen_para = para_parzen(pdf_test, 0.5)
######################################################									 % ^^^ window width
######################################################
######################################################%pdfparzen_para =
######################################################%  scalar structure containing the fields:
######################################################%    labels =
######################################################%       1
######################################################%       2
######################################################%    samples =
######################################################%    {
######################################################%      [1,1] =
######################################################%         1.10000   0.95000
######################################################%         0.98000   0.61000
######################################################% .....
######################################################%         0.69000   0.93000
######################################################%         0.79000   1.01000
######################################################%      [2,1] =
######################################################%        -0.010000   0.380000
######################################################%         0.250000  -0.440000
######################################################% .....
######################################################%        -0.110000   0.030000
######################################################%         0.120000  -0.090000
######################################################%    }
######################################################%    parzenw =  0.50000
######################################################
######################################################pp_pdf = pdf_parzen(pdf_test([2 7 12 17],2:end), pdfparzen_para)
######################################################
######################################################%pp_pdf =
######################################################%  9.7779e-001  6.1499e-008
######################################################%  2.1351e+000  4.2542e-006
######################################################%  9.4059e-010  9.8823e-001
######################################################%  2.0439e-006  1.9815e+000
######################################################
######################################################
######################################################
######################################################
######################################################
######################################################
######################################################




%%%%%%%%%%%%%%%%WORKING WITH CARDS SUITS!!!!!!!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%WORKING WITH CARDS SUITS!!!!!!!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%WORKING WITH CARDS SUITS!!!!!!!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%WORKING WITH CARDS SUITS!!!!!!!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%WORKING WITH CARDS SUITS!!!!!!!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%WORKING WITH CARDS SUITS!!!!!!!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%WORKING WITH CARDS SUITS!!!!!!!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

% now you can start work with cared!
[train test] = load_cardsuits_data();

% Our first look at the data
size(train)
size(test)
labels = unique(train(:,1))

[labels'; sum(train(:,1) == labels')]

% the first task after loading the data is checking
% training set for outliers; to this end we usually compute 
% simple statistics: mean, median, std, 
% and/or plot histogram of individual feature: hist
% and/or plot two features at a time: plot2features

##############POINT 1
disp("POINTPOINTPOINTPOINTPOINTPOINTPOINTPOINT111111111111111111111111111111111111111")

disp("OUTLIERS")


[mean(train); median(train)]
%plot to visualize possible outliers
##plot2features(train, 2, 3)

##plot2features(train, 2, 4)


#FAST OUTLIER remotion
[mv mind]=min(train);
train(mode(mind),:)=[];
[mv mind]=max(train);
train(mode(mind),:)=[];

%SPIEGAZIONE DI COME HO TROVATO GLI OUTLIER E CODICE PER LA RIMOZIONE



%%THIS PRODUCES 64 PLOTS, UNCOMMENT IF ANALYSIS OF PLOTS IS DESIRED
##%plotting all the combinations of features to see which one is the best
##for i = 2:8
##  for j = 2:8
##    plot2features(train, i, j)
##  end
##end

%just plot 2 and 4 which give the best clusters
plot2features(train, 2, 4)

disp("POINTPOINTPOINTPOINTPOINTPOINTPOINTPOINT2222222222222222222222222222")

% after selecting features reduce both sets:
train = train(:, [1 2 4]);
test = test(:, [1 2 4]);


pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 
% this window width should be included in your report!

apriori=[ 0.125  0.125  0.125  0.125  0.125  0.125  0.125  0.125 ];
% Point 2 results
base_ercf = zeros(1,3);
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para, apriori) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para, apriori) != test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != test(:,1));
disp("base_ercf")
base_ercf

% POINT 3
disp("POINTPOINTPOINTPOINTPOINTPOINTPOINTPOINT33333333333333333333333333333333333")

% In the next point, the reduce function will be useful, which reduces the number of samples 
% in the individual classes (in this case, the reduction will be the same in all classes - 
% OF THE TRAINING SET)
% Because reduce has to draw samples randomly, the experiment should be repeated 5 times
% In the report, please provide only the mean value and the standard deviation 
% of the error coefficient
apriori=[ 0.125  0.125  0.125  0.125  0.125  0.125  0.125  0.125 ];
parts = [0.1 0.25 0.5];
rep_count = 5; % at least
class_count=rows(labels);
##############################
for redu_coeff = 1:columns(parts)
  
  cf_err = zeros(rep_count, 3);
  
  for i = 1:rep_count
    
    red = reduce(train,  parts(redu_coeff)* ones(1,class_count));
    
    pdfindep_para = para_indep(red);
    pdfmulti_para = para_multi(red);
    pdfparzen_para = para_parzen(red, 0.001);
    
    cf_err(i, 1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para, apriori) ~= test(:,1));
    cf_err(i, 2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para, apriori) ~= test(:,1));
    cf_err(i, 3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) ~= test(:,1));
        
   end
    fprintf("Reduce coefficient %f\n", parts(redu_coeff));
    disp('   pdf_indep  pdf_multi  pdf_parzen');
    disp([  mean(cf_err, 1);std(cf_err, 0, 1); max(cf_err, [], 1);min(cf_err, [], 1)]);
    fprintf("\n");
  
end

% POINT 4
disp("POINTPOINTPOINTPOINTPOINTPOINTPOINTPOINT4444444444444444444444444444444444")

% Point 4 concerns only Parzen window classifier (on the full training set)

parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
parzen_res = zeros(1, columns(parzen_widths));

for i = 1:columns(parzen_widths)
    pdfparzen_para = para_parzen(train, parzen_widths(i));
    parzen_res(i) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) ~= test(:,1));   
end


disp("parzen_widths; parzen_res")
[parzen_widths; parzen_res]
% Plots are sometimes better than numerical results
disp("parzen_widths; parzen_res ------------- semilogx")
semilogx(parzen_widths, parzen_res)
disp("plot finish")

% POINT 5
disp("POINTPOINTPOINTPOINTPOINTPOINTPOINTPOINT55555555555555555555")

% In point 5 you should reduce TEST SET (no need to touch train set)
%
disp("reduction of test set")
apriori = [0.085 0.165 0.165 0.085 0.085 0.165 0.165 0.085];
parts = [0.5 1.0 1.0 0.5 0.5 1.0 1.0 0.5];
rep_count = 5; % at least
class_count=rows(labels);
##############################
  cf_err = zeros(rep_count,5);
  
  for i = 1:rep_count
        
    pdfindep_para = para_indep(train);
    pdfmulti_para = para_multi(train);
    pdfparzen_para1 = para_parzen(train, 0.0005);
    pdfparzen_para2 = para_parzen(train, 0.001);
    pdfparzen_para3 = para_parzen(train, 0.005);
    red = reduce(test, parts);

    cf_err(i,1) = mean(bayescls(red(:,2:end), @pdf_indep, pdfindep_para, apriori) != red(:,1));
    cf_err(i,2) = mean(bayescls(red(:,2:end), @pdf_multi, pdfmulti_para, apriori) != red(:,1));
    cf_err(i,3) = mean(bayescls(red(:,2:end), @pdf_parzen, pdfparzen_para1, apriori) ~= red(:,1));   
    cf_err(i,4) = mean(bayescls(red(:,2:end), @pdf_parzen, pdfparzen_para2, apriori) ~= red(:,1));
    cf_err(i,5) = mean(bayescls(red(:,2:end), @pdf_parzen, pdfparzen_para3, apriori) ~= red(:,1));
  end

    disp('   pdf_indep  pdf_multi  parzen1 parzen2 parzen3');
    disp([  mean(cf_err, 1);std(cf_err, 0, 1); max(cf_err, [], 1);min(cf_err, [], 1)]);
    fprintf("\n");
#---------------------------------------------------------------------


% POINT 6
disp("POINTPOINTPOINTPOINTPOINTPOINTPOINTPOINT666666666666666666666666666666666")

% In point 6 we should consider data normalization

%std(train(:,2:end))
disp("STUDY OF NORMALIZATION")
for i=1:rows(labels)
    samples_by_class = train(train(:, 1) == labels(i), 2:end);
    class_std= std(samples_by_class);
    fprintf("%d    %.4f   %.4f\n", labels(i), class_std(1), class_std(2));%feature one and feature 2
end

disp("NORMALIZATION?")
coeff_err_norm = zeros(3,1);
norm_coeffi= [std(train(:,2)); std(train(:,3))]
norm_coeffi
train_normalized = [train(:, 1) bsxfun(@rdivide, train(:,2),norm_coeffi(1)) bsxfun(@rdivide, train(:,3),norm_coeffi(2));];
test_normalized = [test(:, 1) bsxfun(@rdivide, test(:,2),norm_coeffi(1)) bsxfun(@rdivide, test(:,3),norm_coeffi(2));];

% 1NN
clf1NN = zeros(rows(test), 1);

for i=1:rows(test)
    clf1NN(i) = cls1nn(test(i,2:end),train);
end

disp("1NN error coeff")
mean(clf1NN ~= test(:,  1))


##########################################################################

disp("Try with data normalized for 1NN")
clf1NN_norm = zeros(rows(test_normalized), 1);

for i=1:rows(test_normalized)
    clf1NN_norm (i) = cls1nn(test_normalized(i,2:end),train_normalized);
end

disp("1NN error coeff normalized")
mean(clf1NN_norm ~= test_normalized(:, 1))
