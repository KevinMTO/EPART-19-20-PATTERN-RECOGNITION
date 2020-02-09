function [pcaSet] = pcaTransform(tvec, mu, trmx)
% tvec - matrix containing vectors to be transformed
% mu - mean value of the training set
% trmx - pca transformation matrix
% pcaSet -  outpu set transforrmed to PCA  space

pcaSet = bsxfun(@minus, tvec, mu);
pcaSet = pcaSet * trmx;
