function pdf = pdf_parzen(pts, para)
% Approximates probability density function with Parzen window
% pts  - contains points for which pdf is computed (sample = row)
% para - structure containing parameters:
%	para.labels - class labels
%	para.samples - cell array containing class samples
%	para.parzenw - Parzen window width
% pdf - probability density matrix
%	row count = number of samples in pts
%	column count = number of classes


	% final result matrix
	pdf = rand(rows(pts), rows(para.samples));
	
	% for each clas
    for cl = 1:rows(para.labels)
		% you know number of samples in this class so you can allocate 
		% intermediate matrix (it contains columns f1 f2 ... fn from diagram in instruction)
    
        onedpdfs = zeros(rows(para.samples{cl}), columns(para.samples{cl}));
        h_n = para.parzenw / sqrt(rows(para.samples{cl})); 

    		% for each sample in pts
        for sampleId =1:rows(pts)
    			% for each feature
    			for j = 1:columns(para.samples{cl})
                % fill proper column in onedpdfs with call to normpdf
    				onedpdfs(:,j)= normpdf(para.samples{cl}(:,j), pts(sampleId,j),h_n);
    			end
           
     	    % aggregate onedpdfs into a scalar value
		    	% and store it in proper element of pdf
                pdf(sampleId, cl) = mean(prod(onedpdfs,2));
        end
     end

end
