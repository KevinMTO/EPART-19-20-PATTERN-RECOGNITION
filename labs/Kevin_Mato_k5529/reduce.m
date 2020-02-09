function rds = reduce(ds, parts)
% Function reducing samples count of individual classes in ds
% ds - data set to be reduced (sample = row; in the first column labels)
% parts - row vector of reduction coefficients for individual classes
%	(1 means no reduction; 0 means no samples of given class to be left)
% rds - reduced data set

	labels = unique(ds(:,1));
  
	if rows(labels) ~= columns(parts)
		error("Class number does not agree with the coefficients number.");
	end

	if max(parts) > 1 || min(parts) < 0
		error("Invalid reduction coefficients.");
	end

 rds = [];
 
  for i=1:rows(labels)
    indexes = find(ds(:,1) == labels(i));
    samples_by_class = ds(indexes, :);
    num_of_samples = ceil(rows(samples_by_class)*parts(i));
    rds = [rds; samples_by_class( randperm(rows(samples_by_class),num_of_samples) ,:) ];
  endfor
  
end
	