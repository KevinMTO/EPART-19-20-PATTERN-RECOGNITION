function rds= reduce(tset,tlab,lab,percent)
  
  
  labels = unique(tlab);
  rds=[];
 
   for i=1:rows(labels)
     if(i!=lab)
      all_other = tset(tlab == labels(i),:);
      num_of_samples = ceil(rows(all_other)*percent);
      rds = [rds; all_other( randperm(rows(all_other),num_of_samples) ,:) ];
     end
  endfor
end
