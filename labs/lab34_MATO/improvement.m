function clab= improvement(tset, ovr, ovo)
  
	labels = unique(ovr(:, 1));
  
	reject = max(labels) + 1;
  draw=reject+1;

  votes = OVRvoting(tset, ovr);
######filters
  valids = sum(votes,2) ==1;
  
  recycle= sum(votes,2)!=1;
  size(find(recycle == 1))
#############good votes
  decisions = votes .*valids;
  
  [mv clab]= max(decisions,[],2);
  #clab;
  size(clab(recycle))
  clab(recycle)=draw;
  clab;
####################
#mapping votes recycled
  #size(tset(recycle,:))
  second_voting = unamvoting(tset(recycle,:), ovo);
  mapping=[second_voting  zeros(rows(second_voting), 1)];
  #size(mapping)
  count=0;
  for k=1:rows(clab)
    if(clab(k)==draw)
        count=count+1;
        for  i=1:rows(mapping)
          if(mapping(i,2)==0)
               clab(k)= mapping(i,1);
               mapping(i,2)=1;#mapped
               break;
           end
        end
    end
  end

  count#countdown to see if function has halt
#what was rejected and not modified stays rejected
  
end
