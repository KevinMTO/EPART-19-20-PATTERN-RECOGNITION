function pdf = pdf_indep(pts, para)
% Computes probability density function assuming feature independence
% pts  - contains points for which pdf is computed (sample = row)
% para - structure containing parameters:
%	para.labels - class labels
%	para.mu - features' mean values (row per class)
%	para.sig - features' standard deviations (row per class)
% pdf - probability density matrix
%	row count = number of samples in pts
%	column count = number of classes

	% final result matrix
	pdf = zeros(rows(pts), rows(para.mu));
	
	% intermediate (one dimensional) density matrix
	onepdfs = zeros(rows(pts), columns(para.mu));

	for cl= 1:rows(para.mu)
	    for f= 1:columns(para.mu)
	    onepdfs(:,f)= normpdf(pts(:,f), para.mu(cl,f), para.sig(cl,f));
	    end
	    pdf(:,cl) = prod(onepdfs,2); 
	end


end