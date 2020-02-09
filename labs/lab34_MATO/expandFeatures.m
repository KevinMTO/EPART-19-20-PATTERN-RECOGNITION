function tsetExpanded = expandFeatures(tset)
% Adds additional features xi .* xj where i <= j
% tset - samples matrix (either train or test)
% tsetExpanded - samples matrix with new features (how many?)

  ftcnt = columns(tset);
  newftcnt = ftcnt + ftcnt * (ftcnt - 1) / 2;
  tsetExpanded = [tset, zeros(rows(tset), newftcnt)];
  ftindex = columns(tset) + 1;
  for i = 1:columns(tset)
	for j = i:columns(tset)
	  tsetExpanded(:, ftindex) = tset(:,i).*tset(:,j);
	  ftindex += 1;
	end
  end
