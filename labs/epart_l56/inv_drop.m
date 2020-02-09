function mask=inv_drop(rows, remove)

  filter= ones(rows,1);
  how_many_zeros=rows*remove;

  for i=1:how_many_zeros
    filter(i,:)=0;
  end

  mask = filter(randperm(rows),:);

end
